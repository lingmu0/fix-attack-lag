# Fix Attack Lag release artifacts

These are the runtime JARs built from the corresponding subprojects. Each
filename identifies its Minecraft version and mod loader. The two existing
artifacts are included alongside the new ports so the repository is a single
download location.

| File | Minecraft | Loader |
| --- | --- | --- |
| `fix_attack_lag-1.3.0-fabric-1.18.2.jar` | 1.18.2 | Fabric |
| `fix_attack_lag-1.3.0-fabric-1.19.2.jar` | 1.19.2 | Fabric |
| `fix_attack_lag-1.3.0-fabric-1.20.1.jar` | 1.20.1 | Fabric |
| `fix_attack_lag-1.3.0-fabric-1.21.1.jar` | 1.21.1 | Fabric |
| `fix_attack_lag-1.3.0-forge-1.12.2.jar` | 1.12.2 | Forge |
| `fix_attack_lag-1.3.0-forge-1.16.5.jar` | 1.16.5 | Forge |
| `fix_attack_lag-1.3.0-forge-1.18.2.jar` | 1.18.2 | Forge |
| `fix_attack_lag-1.3.0-forge-1.19.2.jar` | 1.19.2 | Forge |
| `fix_attack_lag-1.2.0-forge-1.20.1.jar` | 1.20.1 | Forge |
| `fix_attack_lag-1.2.0-neoforge-1.21.1.jar` | 1.21.1 | NeoForge |
| `fix_attack_lag-1.3.0-neoforge-26.1.2.jar` | 26.1.2 | NeoForge |

To calculate SHA-256 values for the current JARs, run
`Get-FileHash .\release\*.jar -Algorithm SHA256` from the repository root.
