# GPG module

This document covers the GPG helper in [modules/.zsh_gpg](../../modules/.zsh_gpg).

## Purpose

The GPG module ensures the environment is configured correctly for interactive GPG operations, especially when the key agent is managed through a pass-based helper. It also refreshes the GPG agent state once per session when a preset script exists.

## Main behavior

- exports `GPG_TTY` so commands that require terminal input work correctly
- checks for a per-user preset script in `~/.gnupg/scripts/gpg-preset-from-pass.sh`
- refreshes preset settings once per session if the script is present and the gpg agent socket has changed
- keeps the runtime quiet when no GPG preset script is available

## Idea behind the module

This module exists to reduce the friction of agent-based signing and pass-entry integration. It keeps the environment stable across interactive shells and ensures commands can prompt for keys or passphrases without ambiguity.

## Recommended workflow

```bash
source ~/.zshrc
gpg --list-secret-keys
```

The happier path is to have the GPG agent connected and the pass-based preset script installed so signing and key operations work without repeated manual setup.

## Setup

```bash
mkdir -p ~/.gnupg/scripts
# place your preset script in ~/.gnupg/scripts/gpg-preset-from-pass.sh
chmod +x ~/.gnupg/scripts/gpg-preset-from-pass.sh
source ~/.zshrc
```

Once present, the module detects the script and applies the agent preconfiguration once, rather than doing it on every prompt cycle.
