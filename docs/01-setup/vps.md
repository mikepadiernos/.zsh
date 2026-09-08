# VPS and server setup

Use this path when the shell runtime is installed on a headless server, remote VPS, or non-interactive Linux environment.

## Goal

Keep startup quiet, deterministic, and safe while enabling the minimal runtime needed for remote administration and automation.

## Default first install

```bash
git clone <your-zsh-runtime-url> ~/.zsh
cd ~/.zsh
source ~/.zshrc
zsh_health
```

For headless systems, the plugin installation is usually kept explicit instead of being bundled into the startup flow. This keeps the runtime conservative and low-noise in automation contexts.

## Core principles

- do not allow noisy auto-installs during shell startup
- keep the runtime safe in non-root and non-interactive contexts
- prefer explicit command execution over automated dependency installation at shell startup
- treat plugin installation and tool updates as deliberate maintenance tasks

## Prerequisites

```bash
sudo apt-get update
sudo apt-get install -y git curl zsh build-essential
```

If you are root, keep the shell in a conservative mode and avoid broad install flows unless you want them explicitly.

## First clone

```bash
git clone <your-zsh-runtime-url> ~/.zsh
```

## Recommended flow

```bash
cd ~/.zsh
source ~/.zshrc
zsh_health
```

For a VPS, plugin installation is usually a deliberate step instead of a startup default:

```bash
zsh_plugins --install
zsh_plugins --check-forks --dry-run
```

## Update and maintenance policy

For headless systems, use preview-based maintenance:

```bash
./scripts/update-tools.sh --scheduled --dry-run
```

This keeps the machine stable and avoids broad package changes during interactive sessions.

## Common validation commands

```bash
whoami
uname -a
zsh_health
set -o | grep -E 'interactive|monitor'
```

## Notes

- this profile is intentionally quiet in automation contexts
- if you need a machine to be server-safe, avoid aggressive package installs at login time
- prefer `tools --update --dry-run` and `zsh_plugins --check-forks --dry-run` before actual changes

## See also

- [desktop.md](desktop.md)
- [wsl.md](wsl.md)
- [../02-configs/zsh_setup.md](../02-configs/zsh_setup.md)
