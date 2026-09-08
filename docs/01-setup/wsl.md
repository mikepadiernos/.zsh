# WSL setup

Use this path when the runtime is installed inside a Windows Subsystem for Linux environment.

## Goal

Keep the shell startup quiet and stable while giving the WSL environment the expected shell features and host-aware behavior.

## Default first install

```bash
git clone <your-zsh-runtime-url> ~/.zsh
cd ~/.zsh
source ~/.zshrc
zsh_plugins --install
zsh_health
```

This is the standard WSL bootstrap path: clone the runtime, source the shell config, install the managed plugin set, and confirm the environment state with the health report.

## Prerequisites

Ensure the WSL distro has the basic packages available:

```bash
sudo apt-get update
sudo apt-get install -y git curl zsh build-essential
```

If you use a separate dotfiles repo, ensure `~/.files` is present before link setup.

## First clone

```bash
git clone <your-zsh-runtime-url> ~/.zsh
```

## Recommended flow

```bash
cd ~/.zsh
zsh_plugins --install
source ~/.zshrc
zsh_health
```

## WSL-specific notes

- use the same shell runtime as your Linux distro; do not rely on Windows shell behavior
- in WSL, detect the environment via the WSL helpers and clipboard integration modules
- prefer previewing commands before doing broad local maintenance
- if the distro is used only for remote work, keep the install minimal and avoid extra GUI assumptions

## Common validation commands

```bash
uname -a
zsh_health
zsh_plugins --check-forks --dry-run
```

## See also

- [desktop.md](desktop.md)
- [vps.md](vps.md)
- [../02-configs/zsh_setup.md](../02-configs/zsh_setup.md)
