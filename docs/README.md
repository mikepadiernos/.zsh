# Zsh runtime documentation

This is the main documentation hub for the shell runtime. It is organized around the actual structure of the repo and the runtime itself, rather than historical or duplicated pages.

## Documentation map

### Core runtime

- [00-core](00-core) — bootstrap, startup flow, core zsh semantics, completions, themes, modules, plugins, and update model
- [00-core/bootstrap.md](00-core/bootstrap.md) — how the shell boots and how the loader order is meant to work
- [00-core/core-zsh.md](00-core/core-zsh.md) — the fundamental shell behavior behind the runtime
- [00-core/completions.md](00-core/completions.md) — completion system and lazy completion loading
- [00-core/themes-loading.md](00-core/themes-loading.md) — how prompt themes are selected and loaded
- [00-core/modules-loading.md](00-core/modules-loading.md) — how module files are sourced and ordered
- [00-core/plugins-loading.md](00-core/plugins-loading.md) — plugin discovery, dependency policy, and safety checks
- [00-core/updates.md](00-core/updates.md) — update, maintenance, and project refresh workflow

### Setup and environment

- [01-setup](01-setup) — installation paths by environment
- [01-setup/desktop.md](01-setup/desktop.md) — local workstation setup
- [01-setup/wsl.md](01-setup/wsl.md) — WSL setup
- [01-setup/vps.md](01-setup/vps.md) — VPS or server setup

### Configs

- [02-configs](02-configs) — shell config fragments and runtime helper configuration
- [02-configs/zsh_health.md](02-configs/zsh_health.md) — project and environment health report
- [02-configs/zsh_history.md](02-configs/zsh_history.md) — history behavior and shell recall configuration
- [02-configs/zsh_prompt.md](02-configs/zsh_prompt.md) — prompt layout, glyphs, and shell UX
- [02-configs/zsh_setup.md](02-configs/zsh_setup.md) — bootstrap, setup, and repo initialization helpers
- [02-configs/zsh_tools.md](02-configs/zsh_tools.md) — tooling updates and symlink maintenance

### Modules

- [03-modules](03-modules) — lazy helper modules for language/tool runtimes
- [03-modules/zsh_atuin.md](03-modules/zsh_atuin.md) — shell history sync and Atuin integration
- [03-modules/zsh_composer.md](03-modules/zsh_composer.md) — Composer helpers
- [03-modules/zsh_docker.md](03-modules/zsh_docker.md) — Docker and Compose runtime helpers
- [03-modules/zsh_drush.md](03-modules/zsh_drush.md) — Drush and Drupal-oriented helpers
- [03-modules/zsh_gh.md](03-modules/zsh_gh.md) — GitHub CLI helpers
- [03-modules/zsh_git.md](03-modules/zsh_git.md) — Git profile and auth setup
- [03-modules/zsh_go.md](03-modules/zsh_go.md) — Go toolchain and project helpers
- [03-modules/zsh_homebrew.md](03-modules/zsh_homebrew.md) — Homebrew and package management helpers
- [03-modules/zsh_mise.md](03-modules/zsh_mise.md) — mise bootstrap and toolchain activation
- [03-modules/zsh_nextcloud.md](03-modules/zsh_nextcloud.md) — Nextcloud related helpers
- [03-modules/zsh_node.md](03-modules/zsh_node.md) — Node and NVM-aware project behavior
- [03-modules/zsh_nvidia.md](03-modules/zsh_nvidia.md) — NVIDIA helpers
- [03-modules/zsh_python.md](03-modules/zsh_python.md) — Python virtualenv and project activation
- [03-modules/zsh_wsl.md](03-modules/zsh_wsl.md) — WSL detection and environment behavior

### Plugins

- [04-plugins](04-plugins) — managed plugin catalog and plugin maintenance flow
- [04-plugins/management.md](04-plugins/management.md) — plugin lifecycle, install, drift checks, and dependency safety

### Themes

- [05-themes](05-themes) — prompt and visual theme definitions
- [05-themes/prompt-themes.md](05-themes/prompt-themes.md) — theme selection and prompt styling

## Quick start

```bash
git clone <your-zsh-runtime-url> ~/.zsh
cd ~/.zsh
source ~/.zshrc
zsh_plugins --check-forks --dry-run
zsh_health
```

## Typical workflow

```bash
source ~/.zshrc
zsh_themes --list
zsh_setup --setup-venv
zsh_plugins --install
./scripts/update-tools.sh --dry-run
zsh_health
```

This is the usual path for validating the runtime, preparing a working environment, applying plugin or tool refreshes, and checking project health before maintenance is accepted.

## What this runtime does

This project is a managed zsh runtime and shell environment for quiet, reliable developer use. It intentionally keeps startup lean and safe, especially in WSL, VPS, and non-interactive shell contexts.

The main capabilities are:

- project-aware shell environment detection
- lazy module loading for language and system tooling
- managed plugin installation and fork drift checks
- prompt theme selection and shell UX tuning
- health reporting for the current project and environment
- safe updates and symlink-based config maintenance

## Reference conventions

- The runtime entrypoint is [.zshrc](../.zshrc)
- Startup logic lives in [configs/.zsh_bootstrap](../configs/.zsh_bootstrap), [configs/.zsh_load_configs](../configs/.zsh_load_configs), and [configs/.zsh_load_modules](../configs/.zsh_load_modules)
- Feature configuration lives under [configs](../configs)
- Lazy runtime helpers live under [modules](../modules)
- Managed plugins live under [plugins](../plugins)
- Prompt themes live under [themes](../themes)
- OS-specific install guidance lives in [01-setup](01-setup)

## When to use which docs

- Start here when you want the overall concept: [00-core](00-core)
- Need installation help: [01-setup](01-setup)
- Need configuration behavior: [02-configs](02-configs)
- Need runtime helpers and environment features: [03-modules](03-modules)
- Need plugin lifecycle or drift handling: [04-plugins](04-plugins)
- Need prompt or visual behavior: [05-themes](05-themes)

This landing page is intentionally a map, not a duplicate of the deeper docs. For implementation details, follow the section-specific pages above.
