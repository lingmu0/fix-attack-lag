# Fix Attack Lag

Fixes the client lag caused by the large damage-indicator particle burst emitted during a single player attack. The mod changes only the particle count argument to zero; it does not change damage, cooldowns, hunger, difficulty, or entity behavior.

CurseForge: [Fix Attack Lag](https://www.curseforge.com/minecraft/mc-mods/fix-attack-lag)

## Supported ports

| Directory | Minecraft | Loader | Release line |
| --- | --- | --- | --- |
| `fabric-1.19.2` | 1.19.2 | Fabric | 1.3.0 |
| `fabric-1.20.1` | 1.20.1 | Fabric | 1.3.0 |
| `fabric-1.21.1` | 1.21.1 | Fabric | 1.3.0 |
| `forge-1.12.2` | 1.12.2 | Forge | 1.3.0 |
| `forge-1.16.5` | 1.16.5 | Forge | 1.3.0 |
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

The verification environment used this toolchain matrix:

| Targets | Java used to build | Gradle wrapper |
| --- | --- | --- |
| Fabric 1.19.2, 1.20.1, 1.21.1 | JDK 21 (Fabric 1.19/1.20 bytecode target is Java 17) | 9.2.1 |
| Forge 1.16.5, 1.19.2, 1.20.1 | JDK 17 | 8.8 |
| NeoForge 1.21.1 | JDK 21 | 8.8 |
| Forge 1.12.2 | JDK 8 | 4.9 |
| NeoForge 26.1.2 | JDK 25 | 9.2.1 |

Forge 1.12.2 embeds the Java 8-compatible Mixin runtime and includes the legacy Mixin manifest entries. NeoForge 26.1.2 uses the official ModDevGradle 26.1.2 template and Java 25.

## Verification

All nine module projects have passed `clean build` in the development environment. No Minecraft client or dedicated server was launched as part of the build verification; test runs should be performed in a clean instance for the relevant loader.

## License

The project is released under the MIT License. See [LICENSE](LICENSE).
