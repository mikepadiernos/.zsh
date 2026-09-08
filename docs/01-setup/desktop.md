# Desktop and workstation setup

Use this path for a normal local machine or a Linux/macOS workstation where you want the zsh runtime installed as your interactive shell.

## Goal

Install the shell runtime, load the config stack, and make sure the local machine is ready for day-to-day work without noisy startup behavior.

## Default first install

```bash
git clone <your-zsh-runtime-url> ~/.zsh
cd ~/.zsh
source ~/.zshrc
zsh_plugins --install
zsh_health
```

This is the standard first-clone flow for a workstation. The shell loads the bootstrap stack, installs the managed plugin set, and checks the current environment health before you start routine maintenance.

## Prerequisites

Install the basics if they are missing:

```bash
# Linux (Debian/Ubuntu example)
sudo apt-get update
sudo apt-get install -y git curl zsh build-essential

# macOS
xcode-select --install
brew install git curl zsh
```

If you keep your dotfiles in a separate repo, make sure it is available at `~/.files` before running the link setup.

## First clone

```bash
git clone <your-zsh-runtime-url> ~/.zsh
```

If you keep dotfiles separately:

```bash
git clone <your-dotfiles-url> ~/.files
```

## Recommended install flow

```bash
cd ~/.zsh
zsh_plugins --install
source ~/.zshrc
zsh_health
tools --update --dry-run
```

## What happens in this flow

1. the shell loads the bootstrap stack
2. config fragments are sourced in the normal startup order
3. plugin repos are installed from the managed plugin manifest
4. the runtime is validated by printing the health report
5. the update pass is previewed before performing changes

## Optional: make it your default shell

```bash
chsh -s "$(which zsh)"
```

If the shell is already installed and you want a normal local terminal experience, this is usually the last step.

## Post-install checks

Run these after startup:

```bash
zsh_themes --list
zsh_plugins --check-forks --dry-run
zsh_python --status
zsh_health
```

## Notes

- keep startup quiet and non-interactive for servers and automation contexts
- prefer previewing `tools --update --dry-run` before applying real maintenance
- if the host is not a developer box, skip heavier local integrations and follow the VPS guide instead

## See also

- [wsl.md](wsl.md)
- [vps.md](vps.md)
- [../02-configs/zsh_setup.md](../02-configs/zsh_setup.md)
