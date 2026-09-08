# Completion system

This document explains how zsh completion is enabled and how command completions are loaded in this runtime.

## Source of truth

The completion logic lives in [configs/.zsh_completions](../../configs/.zsh_completions) and is loaded from [configs/.zsh_load_configs](../../configs/.zsh_load_configs).

## What the completion layer does

The completion system is responsible for:

- enabling `compinit` in interactive shells
- setting a stable zcompdump cache directory
- extending `fpath` with the managed zsh completions bundle
- loading tool-specific completion definitions lazily when the command exists
- registering shell helpers for commands such as `zsh_themes`, `zsh_setup`, and `zsh_python`

## Core behavior

The runtime sets `ZSH_DISABLE_COMPFIX=true` to avoid the common zsh completion fix workflow that often causes noisy or brittle shell startup. It then adds the completion sources from the plugin bundle:

```zsh
fpath+=("${ZSH_PLUGINS}/zsh-completions/src")
```

If the shell is interactive, it runs `autoload -Uz compinit` and then initializes the completion system with `compinit` using a cached dump file under `$HOME/.cache/zsh`.

The module also defines helper functions such as:

- `_load_zsh_completion`
- `_lazy_load_zsh_completion`
- `_has_completion_file`
- `_use_system_or_generated_completion`

These helpers avoid generating or loading completion scripts when the command is missing or when a system completion already exists.

## Lazy completion loading

The runtime loads many completions lazily. Examples include:

- Docker
- Docker Compose
- `kubectl`
- `helm`
- `gh`
- `argocd`
- `az`
- `direnv`
- `lazygit`
- `rclone`

This keeps the startup fast and avoids forcing every command into memory just to provide completion support.

## Custom completions

The completion file also registers custom completion logic for project commands such as:

- `zsh_themes`
- `zsh_setup`
- `zsh_python`
- `zsh_plugins`

This lets the shell complete flags and options in the same style as the rest of the system, without requiring manual shell alias hacks.

## Recommended workflow

```bash
source ~/.zshrc
zsh_themes --list
zsh_setup --help
zsh_python --help
```

When a command is installed and completion support is available, tab completion usually becomes available immediately. When not, the runtime falls back to either a generated completion or the system completion loader without failing the shell.

## Troubleshooting

If completion behavior is missing:

- confirm the command is installed and on `PATH`
- verify that the shell is interactive
- check whether the command-specific completion loader is available in `$fpath`
- remove the stale zcompdump cache if completion state appears corrupted

## Description

The completion system is intentionally lightweight and tool-aware. It keeps shell startup quiet while still enabling rich command completion for the most common developer tools and custom runtime commands.
