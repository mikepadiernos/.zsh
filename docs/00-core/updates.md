# Updating the project, tools, and features

This document explains how to keep the shell runtime, the managed toolchain, and the project-specific features in sync without introducing startup noise or surprise installs.

## Update philosophy

This runtime is intentionally conservative:

- startup is quiet and safe by default
- package installs are opt-in or intentionally triggered
- plugin refreshes are reviewable before they are applied
- repo and config updates are explicit, not hidden side effects

The design goal is predictable maintenance rather than aggressive auto-updates.

## Project update categories

The project has several layers that can be updated independently:

1. the shell runtime repository itself
2. the managed zsh plugin set
3. the local toolchain managed through `mise` or package managers
4. application configuration links managed from `~/.files`
5. project-local feature setup such as `.venv`, Drupal/DDEV, or workspace-specific config

Each layer should be updated intentionally and validated with the runtime health checks.

## Updating the shell runtime repository

When the repo itself needs a refresh, use the normal Git flow from the repo root:

```bash
cd ~/.zsh
git pull --ff-only
source ~/.zshrc
zsh_health
```

The runtime should remain source-safe and quiet after each refresh. If there is a plugin or environment change, the next step is usually a targeted plugin or tool update rather than an immediate broad reinstall.

## Updating the managed tooling stack

The project’s update entrypoint is [scripts/update-tools.sh](../../scripts/update-tools.sh). It wraps the runtime’s tool command and adds safe defaults for root and scheduled environments.

### Standard update flow

```bash
cd ~/.zsh
./scripts/update-tools.sh --dry-run
./scripts/update-tools.sh
```

The script is designed to:

- run `tools --update`
- disable brew updates when running as root
- skip risky update stages in scheduled mode
- optionally install or enable the user systemd timer

Examples:

```bash
./scripts/update-tools.sh --scheduled
./scripts/update-tools.sh --ensure-user-timer
./scripts/update-tools.sh --no-flatpak --no-vscode
```

### Tooling internals

The actual maintenance logic lives in [configs/.zsh_tools](../../configs/.zsh_tools). It manages:

- a list of `mise` packages to keep current
- symlink creation from the `$FILES` directory into `$HOME`
- custom application links and counterpart links
- optional tool gating when specific apps are missing
- display of a human-readable status table

The `tools` command is the main way to repair or reapply configuration links, update the managed toolchain, and keep the local machine configuration in sync with the repo-managed files.

## Updating the plugin stack

The managed plugin set is defined in [plugins/git_repos.txt](../../plugins/git_repos.txt) and is loaded via [configs/.zsh_plugins](../../configs/.zsh_plugins).

Use the plugin review flow before applying changes:

```bash
source ~/.zshrc
zsh_plugins --check-forks --dry-run
zsh_plugins --install
```

This is the recommended maintenance pattern because it keeps plugin drift under control and gives you a preview before you update or install the managed plugin repos.

The plugin loader also enforces dependency checks and a safe install strategy:

- prefer `mise` when a matching package exists
- use `brew` only for non-root users when needed
- avoid noisy or eager installs during normal shell startup

## Updating shell features and configs

The runtime has multiple feature layers, each with its own update pattern.

### Theme and prompt

Use the theme loader to inspect and switch prompt styles:

```bash
source ~/.zshrc
zsh_themes --list
zsh_themes --theme minimal
```

The prompt, glyph, and theme behavior is defined in [configs/.zsh_prompt](../../configs/.zsh_prompt) and [configs/.zsh_themes](../../configs/.zsh_themes).

### Setup and bootstrap helpers

Project bootstrap is handled by [configs/.zsh_setup](../../configs/.zsh_setup):

```bash
source ~/.zshrc
zsh_setup --setup-venv
zsh_setup --pull-repos
zsh_setup --setup-all
```

This workflow handles:

- virtualenv creation
- repo cloning
- bootstrap of `mise`
- tooling installation
- plugin install
- symlink application

### Health checks

After updates, always validate the current shell and project context:

```bash
source ~/.zshrc
zsh_health
```

This reports the active environment, Docker context, DDEV status, Drupal status, and project type if applicable.

## Updating symlinks and config files

The tool chain also maintains the user-level config file links via the `FILES` root. This is a major part of the runtime’s update model.

A standard maintenance flow is:

```bash
source ~/.zshrc
tools --setup-links
tools --status
```

This keeps the live machine configuration synchronized with the repository-managed app config under `~/.files` without requiring manual copy steps every time the runtime is refreshed.

## Recommended maintenance workflow

Use this sequence as the regular update path:

```bash
cd ~/.zsh
source ~/.zshrc
zsh_plugins --check-forks --dry-run
./scripts/update-tools.sh --dry-run
./scripts/update-tools.sh
zsh_health
```

This gives a safe path for:

- detecting drift
- reviewing tool updates
- applying required maintenance
- validating that the project environment still looks healthy after the changes

## Safety rules

The project strongly prefers these rules during maintenance:

- never rely on startup-time installs as the default behavior
- keep `brew` fallback for non-root users only when necessary
- keep root and server-mode startup quiet
- prefer dry-run previews before making major updates
- validate the environment after any tooling or plugin maintenance

## Where the update logic lives

The update logic is spread across the runtime deliberately:

- [scripts/update-tools.sh](../../scripts/update-tools.sh) — repo-level update entrypoint
- [configs/.zsh_tools](../../configs/.zsh_tools) — tool update, link management, and status logic
- [configs/.zsh_plugins](../../configs/.zsh_plugins) — plugin install and dependency safety
- [configs/.zsh_setup](../../configs/.zsh_setup) — setup and bootstrap maintenance
- [configs/.zsh_health](../../configs/.zsh_health) — validation and project state checks

## Description

The update system is designed to be safe and explicit. Rather than forcing changes at shell startup, the runtime exposes clear review and maintenance commands that can be run intentionally, validated, and rolled back if necessary.
