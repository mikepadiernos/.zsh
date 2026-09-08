# Atuin module

This document covers the Atuin history integration in [modules/.zsh_atuin](../../modules/.zsh_atuin).

## Purpose

The Atuin module keeps shell history in a managed, portable location instead of relying only on the local shell history file. It is designed to work well with a dotfiles-first workflow where `~/.files` is the canonical config home.

## Main behavior

- defines the hosted config and data roots used by Atuin under `~/.files/.atuin`
- keeps `~/.config/atuin` and `~/.local/share/atuin` as symlink targets backed by the repo-managed files
- checks whether Atuin is installed before trying to initialize it
- runs `atuin init zsh` lazily during shell startup when the binary is present
- can install Atuin via `mise` or `cargo` when it is missing
- can import an existing `.zsh_history` file, set up a minimal config, and run login or sync steps on demand

## Idea behind the module

The shell runtime tries to avoid hard-to-reproduce local state. The Atuin module keeps the user’s command history in a predictable location while still letting the shell behave normally. This makes the config portable across workstations, laptops, and WSL instances without losing the benefit of a richer command log.

## Recommended workflow

```bash
source ~/.zshrc
zsh_atuin_setup_main --install --import-history
atuin login
atuin sync
```

For a preexisting machine, the usual flow is to install Atuin once, import the existing zsh history, and then let the shell keep history synced through Atuin.

## Setup

```bash
cd ~/.zsh
source ~/.zshrc
zsh_atuin_setup_main --install --symlink-only
zsh_atuin_setup_main --import-history --history-file ~/.zsh_history
zsh_atuin_setup_main --login --sync
```

This installs or confirms the Atuin binary, creates the expected config/data layout, symlinks the runtime paths into place, and gives the shell a stable history backend without depending on a hidden local state.
