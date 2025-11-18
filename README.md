# UMBRELLA-ADS

_a.k.a. UMBRELLADS_

Umbrella Ads Archive is a single-page experience that showcases the 18.NOV2025 marketing drop for Umbrella Corporation. The directory includes a curated, human-readable HTML file plus legacy and decoded references so the original obfuscation can be studied without touching production assets.

## Repository Layout
- `Umbrella 18.NOV2025.html` – actively maintained campaign page featuring neon scanlines, matrix rain, and modular telemetry cards.
- `Umbrella_18.NOV2025.decoded.html` – straight decode of the obfuscated source for forensic reference.
- `Umbrella Corporation By_NND.html` – untouched legacy version used for historic auditing.
- `AGENTS.md` – contributor playbook outlining structure, commands, testing habits, and the in-universe “HIVE Liaison” persona.
- `deploy_to_github.sh` – helper script that initializes git, configures remotes, and pushes the workspace to GitHub.
- `readme.txt` – original handoff note that shipped with the archive.

## Development Notes
Serve the primary HTML file with `python3 -m http.server 8080` to preview animations locally. Run `tidy -qe 'Umbrella 18.NOV2025.html'` before committing to ensure structural validity. Keep reference files immutable unless a historical capture must be refreshed.
