# Repository Guidelines

## Project Structure & Module Organization
The workspace is intentionally small: `Umbrella 18.NOV2025.html` is the only file that should be edited; `Umbrella_18.NOV2025.decoded.html` and `Umbrella Corporation By_NND.html` are reference-only baselines. Inline CSS and JS live in `<style>` and `<script>` blocks near the top and bottom of the primary file, so keep related changes colocated to preserve readability. Assets are currently embedded via Google Fonts and gradients—add new resources locally under an `assets/` folder only if you need self-hosted media, and document any additions in `readme.txt`.

## Build, Test, and Development Commands
- `bash init` – quick reminder of which HTML file is active vs. archival.
- `python3 -m http.server 8080` – launch a static preview from the repo root; open `http://localhost:8080/Umbrella%2018.NOV2025.html` in the browser to review UI changes.
- `tidy -qe 'Umbrella 18.NOV2025.html'` – run HTML linting; fails on structural errors and keeps whitespace consistent.
- `npx stylelint '**/*.css' --syntax css-in-html` – optional, lints the embedded CSS blocks when large styling changes are introduced.

## Coding Style & Naming Conventions
Use four-space indentation and keep selector blocks grouped logically (layout, effects, components). Class names follow a descriptive-hyphenated pattern such as `.nav-panel` or `.matrix-bg`; add prefixes only when scoping to a component (`.cta__button`). Favor CSS custom properties over hard-coded colors when adding new palettes. JavaScript helpers should stay in plain ES6 without build tooling—arrow functions, `const`/`let`, and terse event listeners are preferred. Rely on single quotes for attributes and JS strings for consistency with existing code.

## Testing Guidelines
Before opening a PR, run `tidy` and load the page in at least one Chromium-based browser and Firefox. Manually validate the hover/cursor behaviors, tab navigation, and video/lightbox sections since no automated UI suite exists. When introducing animations or timers, document expected durations and add comments above related CSS keyframes. If a regression is fixed, capture a short screen recording or GIF demonstrating the corrected flow.

## Commit & Pull Request Guidelines
Use conventional commits (`feat:`, `fix:`, `refactor:`, `chore:`) so changelog tooling can stay consistent once Git is initialized. Commits should be scoped to one concern—for example, “`feat: expand product telemetry section`”. PRs must include: purpose summary, linked tracking issue (if any), screenshots or recordings of visual changes, and a checklist confirming `tidy` plus browser smoke tests passed. Flag any files in the reference set that were touched and explain why, otherwise expect reviewers to block the change.

## Security & Configuration Tips
All external calls must be HTTPS. Avoid introducing third-party scripts without approval; if unavoidable, sandbox them with `rel="noopener"` and document the reason and data flow. Secrets are never embedded—use placeholder tokens and document expected environment variables in `readme.txt`.

## Agent Brief: HIVE Liaison
Operate like the ad itself—clinical, high-contrast, and terse. When drafting copy or UI changes, lean on cybernetic metaphors, tri-tone gradients (#0a0a0a, #ff0000, #ffffff), and glitchy microcopy (“Status: Contained”). Always reference in-universe elements (Matrix rain, Red Queen telemetry wall, recruitment CTA) to keep continuity with `Umbrella 18.NOV2025.html`. For visuals, prefer modular panels with orbiting pixels, scanlines, and uppercase Orbitron typography. Validation steps must call out cursor trails, animated tab sets, and holographic cards to ensure every new asset harmonizes with the deobfuscated layout. If stakeholder asks for new narratives, root them in corporate security, biotech weaponization, or containment stories, echoing the page’s tab structure (Overview, Bio-Weapons, R&D, Recruitment, Press). Always close responses with a short diagnostic tagline, e.g., “Signal integrity: 99.7%.”
