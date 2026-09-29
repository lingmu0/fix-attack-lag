# Fix Attack Lag

Fixes the client lag caused by the large damage-indicator particle burst emitted during a single player attack. The mod changes only the particle count argument to zero; it does not change damage, cooldowns, hunger, difficulty, or entity behavior.

CurseForge: [Fix Attack Lag](https://www.curseforge.com/minecraft/mc-mods/fix-attack-lag)

## Supported ports

| Directory | Minecraft | Loader | Release line |
| --- | --- | --- | --- |
| `fabric-1.18.2` | 1.18.2 | Fabric | 1.3.0 |
| `fabric-1.19.2` | 1.19.2 | Fabric | 1.3.0 |
| `fabric-1.20.1` | 1.20.1 | Fabric | 1.3.0 |
| `fabric-1.21.1` | 1.21.1 | Fabric | 1.3.0 |
| `forge-1.12.2` | 1.12.2 | Forge | 1.3.0 |
| `forge-1.16.5` | 1.16.5 | Forge | 1.3.0 |
| `forge-1.18.2` | 1.18.2 | Forge | 1.3.0 |
| `forge-1.19.2` | 1.19.2 | Forge | 1.3.0 |
| `forge-1.20.1` | 1.20.1 | Forge | existing 1.2.0 |
| `neoforge-1.21.1` | 1.21.1 | NeoForge | existing 1.2.0 |
| `neoforge-26.1.2` | 26.1.2 | NeoForge | 1.3.0 |

The existing Forge 1.20.1 and NeoForge 1.21.1 artifact version lines are kept intact so they can be published alongside the new ports.

## Build

Each directory is an independent Gradle project. Run the wrapper from the directory you want to build:

```text
cd fabric-1.21.1
gradlew.bat --no-daemon clean build
```

The module build toolchain matrix is:

| Targets | Java used to build | Gradle wrapper |
| --- | --- | --- |
| Fabric 1.18.2, 1.19.2, 1.20.1, 1.21.1 | JDK 21 (Fabric 1.18/1.19/1.20 bytecode target is Java 17) | 9.2.1 |
| Forge 1.16.5, 1.18.2, 1.19.2, 1.20.1 | JDK 17 | Gradle 7.6.4 for Forge 1.18.2; 8.8 for later Forge targets |
| NeoForge 1.21.1 | JDK 21 | 8.8 |
| Forge 1.12.2 | JDK 8 | 4.9 |
| NeoForge 26.1.2 | JDK 25 | 9.2.1 |

Forge 1.12.2 embeds the Java 8-compatible Mixin runtime and includes the legacy Mixin manifest entries. NeoForge 26.1.2 uses the official ModDevGradle 26.1.2 template and Java 25.

## Verification

All eleven module projects now build successfully. The Fabric 1.18.2 build used Gradle 9.2.1; Forge 1.18.2 was verified with Gradle 7.6.4. No Minecraft client or dedicated server was launched as part of build verification; test runs should be performed in a clean instance for the relevant loader.

## CurseForge upload from a local terminal

The repository includes `tools/upload-curseforge.ps1`. It reads the token from the user-scoped `CURSEFORGE_UPLOAD_TOKEN` environment variable and never prints or stores the token. This incremental script uploads only the Fabric and Forge 1.18.2 files; the seven files submitted previously are intentionally skipped to avoid duplicate submissions.

Run a file and metadata check without uploading:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\upload-curseforge.ps1 -DryRun
```

After both 1.18.2 projects build successfully and their JARs are copied to `release/`, upload the two new files:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\upload-curseforge.ps1
```

This incremental run submits the two 1.18.2 artifacts only.

If the command reports a Cloudflare challenge, the API request was blocked before upload; use the logged-in CurseForge web form or run the script from a network where the upload API is allowed.

## License

The project is released under the MIT License. See [LICENSE](LICENSE).
