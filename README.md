# ~/.zsh

This repository is a modular zsh runtime for Linux, macOS, and WSL-centric developer workflows. It is designed to stay quiet, predictable, and safe during startup while still providing project-aware shell behavior, prompt customization, plugin management, and health checks.

## What this project includes

- a stable shell bootstrap and runtime layout
- per-feature config loading for prompt, history, health, tooling, and setup
- lazy helpers for Node, Python, Docker, Git, WSL, Homebrew, and more
- managed plugin installation and drift checks
- prompt and theme helpers for a polished terminal experience
- safe maintenance flows for updates and configuration links
- project health diagnostics for the current shell context

## Repository layout

- [.zshrc](.zshrc) — root zsh entrypoint and runtime environment setup
- [configs](configs) — runtime config fragments and loader files
- [modules](modules) — modular lazy environment helpers
- [plugins](plugins) — managed plugin repositories and plugin metadata
- [themes](themes) — prompt and visual theme files
- [scripts](scripts) — maintenance and update tooling
- [docs](docs) — canonical documentation for the runtime and its subsystems

## Documentation map

The docs section is organized by responsibility:

- [docs/README.md](docs/README.md) — docs landing page and navigation
- [docs/00-core](docs/00-core) — bootstrap, core zsh behavior, completions, theme loading, module loading, plugin loading, and updates
- [docs/01-setup](docs/01-setup) — installation guidance for desktop, WSL, and VPS setups
- [docs/02-configs](docs/02-configs) — config behavior for health, history, prompt, setup, and tool maintenance
- [docs/03-modules](docs/03-modules) — environment helper modules for Python, Node, Docker, Git, and more
- [docs/04-plugins](docs/04-plugins) — plugin lifecycle, dependency safety, and drift detection
- [docs/05-themes](docs/05-themes) — prompt and theme behavior

## Quick start

```bash
cd ~/.zsh
source ~/.zshrc
zsh_plugins --check-forks --dry-run
zsh_health
```

## Common maintenance flow

```bash
cd ~/.zsh
source ~/.zshrc
./scripts/update-tools.sh --dry-run
./scripts/update-tools.sh
zsh_plugins --install
zsh_health
```

## Project priorities

This runtime intentionally favors:

- quiet startup in VPS and non-interactive environments
- safe installs and explicit maintenance actions
- predictable shell behavior over aggressive auto-install logic
- stable, documented patterns over hidden state or surprise updates

## Read the docs

For the complete usage and architecture references, start here:

- [docs/README.md](docs/README.md)
- [docs/00-core/bootstrap.md](docs/00-core/bootstrap.md)
- [docs/01-setup/desktop.md](docs/01-setup/desktop.md)
- [docs/02-configs/zsh_health.md](docs/02-configs/zsh_health.md)
- [docs/03-modules/zsh_python.md](docs/03-modules/zsh_python.md)
- [docs/04-plugins/management.md](docs/04-plugins/management.md)
- [docs/05-themes/prompt-themes.md](docs/05-themes/prompt-themes.md)

This README is intentionally a concise overview; the deeper operational guidance lives in the docs tree above.
