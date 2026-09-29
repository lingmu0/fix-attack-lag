[CmdletBinding()]
param(
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$releaseDir = Join-Path $repoRoot 'release'
$uploadUri = 'https://minecraft.curseforge.com/api/projects/1297930/upload-file'

# This incremental upload contains only the two newly added 1.18.2 ports.
# All other new ports from the previous submission are already under review.
$uploadItems = @(
    [pscustomobject]@{ RelativePath = 'fix_attack_lag-1.3.0-fabric-1.18.2.jar'; DisplayName = 'Fix Attack Lag 1.3.0 - Fabric 1.18.2'; GameVersionNames = @('Client', 'Server', '1.18.2', 'Fabric') }
    [pscustomobject]@{ RelativePath = 'fix_attack_lag-1.3.0-forge-1.18.2.jar'; DisplayName = 'Fix Attack Lag 1.3.0 - Forge 1.18.2'; GameVersionNames = @('Client', 'Server', '1.18.2', 'Forge') }
)

$missing = @(
    $uploadItems | Where-Object {
        -not (Test-Path -LiteralPath (Join-Path $releaseDir $_.RelativePath) -PathType Leaf)
    }
)
if ($missing.Count -gt 0) {
    $missingNames = ($missing | ForEach-Object { $_.RelativePath }) -join ', '
    throw "Missing release artifact(s): $missingNames"
}

if ($DryRun) {
    Write-Host "CurseForge project: 1297930"
    Write-Host "Upload endpoint: $uploadUri"
    $uploadItems | ForEach-Object {
        Write-Host ("[DRY-RUN] {0} <- {1}" -f $_.DisplayName, $_.RelativePath)
    }
    exit 0
}

$token = [Environment]::GetEnvironmentVariable('CURSEFORGE_UPLOAD_TOKEN', 'User')
if ([string]::IsNullOrWhiteSpace($token)) {
    $token = $env:CURSEFORGE_UPLOAD_TOKEN
}
if ([string]::IsNullOrWhiteSpace($token)) {
    throw 'CURSEFORGE_UPLOAD_TOKEN is not set. Set it as a user environment variable before running this script.'
}

Add-Type -AssemblyName System.Net.Http
$client = [System.Net.Http.HttpClient]::new()
$client.DefaultRequestHeaders.TryAddWithoutValidation('X-Api-Token', $token) | Out-Null
$failures = [System.Collections.Generic.List[string]]::new()

try {
    foreach ($item in $uploadItems) {
        $filePath = Join-Path $releaseDir $item.RelativePath
        $multipart = [System.Net.Http.MultipartFormDataContent]::new()
        $metadataContent = $null
        $fileStream = $null
        $fileContent = $null

        try {
            $metadata = [ordered]@{
                changelog = 'Add Fabric and Forge 1.18.2 compatibility ports.'
                changelogType = 'markdown'
                displayName = $item.DisplayName
                gameVersionNames = $item.GameVersionNames
                releaseType = 'release'
                isMarkedForManualRelease = $false
            }
            $metadataJson = $metadata | ConvertTo-Json -Compress -Depth 5
            $metadataContent = [System.Net.Http.StringContent]::new(
                $metadataJson,
                [System.Text.Encoding]::UTF8,
                'application/json'
            )
            $multipart.Add($metadataContent, 'metadata')

            $fileStream = [System.IO.File]::OpenRead($filePath)
            $fileContent = [System.Net.Http.StreamContent]::new($fileStream)
            $fileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse('application/java-archive')
            $multipart.Add($fileContent, 'file', [System.IO.Path]::GetFileName($filePath))

            $response = $client.PostAsync($uploadUri, $multipart).GetAwaiter().GetResult()
            $body = $response.Content.ReadAsStringAsync().GetAwaiter().GetResult()

            if (-not $response.IsSuccessStatusCode) {
                if ($body -match 'Just a moment|Enable JavaScript and cookies') {
                    $detail = 'Cloudflare challenge returned; use the web form or a network that permits the API.'
                } else {
                    $detail = "HTTP $([int]$response.StatusCode)"
                }
                Write-Host "[FAILED] $($item.RelativePath): $detail"
                $failures.Add($item.RelativePath)
                continue
            }

            try {
                $result = $body | ConvertFrom-Json
            } catch {
                $result = $null
            }
            if ($null -eq $result -or $null -eq $result.id) {
                Write-Host "[FAILED] $($item.RelativePath): upload returned no file ID"
                $failures.Add($item.RelativePath)
                continue
            }
            Write-Host "[OK] $($item.RelativePath): fileId=$($result.id)"
        } catch {
            Write-Host "[FAILED] $($item.RelativePath): $($_.Exception.Message)"
            $failures.Add($item.RelativePath)
        } finally {
            if ($null -ne $fileContent) { $fileContent.Dispose() }
            if ($null -ne $fileStream) { $fileStream.Dispose() }
            if ($null -ne $metadataContent) { $metadataContent.Dispose() }
            $multipart.Dispose()
        }
    }
} finally {
    $client.Dispose()
}

if ($failures.Count -gt 0) {
    throw "Upload failed for $($failures.Count) file(s): $($failures -join ', ')"
}

Write-Host 'All requested CurseForge uploads completed.'
