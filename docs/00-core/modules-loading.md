# Module loading

This document explains how the runtime loads the helper modules and why the module list is ordered in a specific way.

## Source of truth

The module list is defined in [configs/.zsh_load_modules](../../configs/.zsh_load_modules), and each module is a file in [modules](../../modules).

## How modules are loaded

The loader builds an array named `zsh_module_files` and then sources each file in order:

```zsh
zsh_module_files=(
  "${ZSH_MODULES}/.zsh_wsl"
  "${ZSH_MODULES}/.zsh_homebrew"
  "${ZSH_MODULES}/.zsh_gpg"
  "${ZSH_MODULES}/.zsh_drush"
  "${ZSH_MODULES}/.zsh_composer"
  "${ZSH_MODULES}/.zsh_python"
  "${ZSH_MODULES}/.zsh_git"
  "${ZSH_MODULES}/.zsh_gh"
  "${ZSH_MODULES}/.zsh_node"
  "${ZSH_MODULES}/.zsh_docker"
  "${ZSH_MODULES}/.zsh_table"
  "${ZSH_MODULES}/.zsh_nextcloud"
  "${ZSH_MODULES}/.zsh_nocsd"
  "${ZSH_MODULES}/.zsh_nvidia"
  "${ZSH_MODULES}/.zsh_mise"
)
```

Each module is then sourced with `source_if_exists`, which silently skips missing files instead of breaking the shell.

## Module responsibilities

The modules are purpose-specific helper layers for distinct domains:

- WSL integration: [modules/.zsh_wsl](../../modules/.zsh_wsl)
- Homebrew integration: [modules/.zsh_homebrew](../../modules/.zsh_homebrew)
- GPG assistant: [modules/.zsh_gpg](../../modules/.zsh_gpg)
- Drupal and DDEV helpers: [modules/.zsh_drush](../../modules/.zsh_drush)
- Composer project context: [modules/.zsh_composer](../../modules/.zsh_composer)
- Python auto-venv: [modules/.zsh_python](../../modules/.zsh_python)
- Git profile and auth helpers: [modules/.zsh_git](../../modules/.zsh_git)
- GitHub CLI support: [modules/.zsh_gh](../../modules/.zsh_gh)
- Node/NVM lazy detection: [modules/.zsh_node](../../modules/.zsh_node)
- Docker and Compose helpers: [modules/.zsh_docker](../../modules/.zsh_docker)
- Table and directory listing: [modules/.zsh_table](../../modules/.zsh_table)
- Nextcloud sync helpers: [modules/.zsh_nextcloud](../../modules/.zsh_nextcloud)
- GTK no-csd compatibility: [modules/.zsh_nocsd](../../modules/.zsh_nocsd)
- NVIDIA offload alias: [modules/.zsh_nvidia](../../modules/.zsh_nvidia)
- `mise` toolchain bootstrapping: [modules/.zsh_mise](../../modules/.zsh_mise)

## Ordering philosophy

The main thing to notice is that `mise` is intentionally loaded last. This lets the `mise` toolchain and its shims override anything from brew or system-level tools in the final `PATH` state.

Most other modules are designed to be lazy and non-intrusive: they detect project context and then activate the relevant part of the environment only when it is needed.

## Recommended workflow

```bash
source ~/.zshrc
zsh_python --status
node -v
docker_runtime
```

This confirms that the relevant modules loaded correctly and that their project-aware behavior is active for the current shell context.

## Troubleshooting

If a module is not behaving as expected:

- confirm the module file exists under [modules](../../modules)
- verify that the shell was started with `source ~/.zshrc`
- check the corresponding module file for environment variables or guards
- inspect whether a later module is overriding an earlier PATH or environment change

## Description

The module system is intentionally narrow in scope. Each module is designed to solve one environment problem at a time, which keeps the shell easy to debug and avoids large startup side effects.
