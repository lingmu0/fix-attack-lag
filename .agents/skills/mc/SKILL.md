---
name: mc
description: Project context for Minecraft mod development and release work in the mc workspace.
metadata:
  short-description: Minecraft workspace and release context
---

# Minecraft workspace context

## GitHub connection

- The Codex GitHub connector is connected to the GitHub account `lingmu0` (verified 2026-09-12).
- This records connection status only; never store OAuth tokens, passwords, API keys, or other credentials here.
- The connector authorization is separate from browser and local Git authentication. Do not assume that a browser session or `git push` is authenticated just because the connector is connected.
- The intended public repository for Fix Attack Lag is `lingmu0/fix-attack-lag`.

## Release context

- The Fix Attack Lag project is at `fix-attack-lag/` and contains independent Fabric, Forge, and NeoForge subprojects.
- Runtime JARs are collected under `fix-attack-lag/release/`.
- CurseForge project ID is `1297930`. Uploads require an authorized CurseForge API token and must never commit or log that token.
