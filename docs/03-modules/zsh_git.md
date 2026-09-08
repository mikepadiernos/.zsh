# Git module

This document covers the Git environment helper in [modules/.zsh_git](../../modules/.zsh_git).

## Purpose

The Git module helps the shell behave more predictably in real-world developer environments. It focuses on preserving user identity and credential flow, making it easier to handle multiple profiles, stale VS Code askpass state, and merge-tool setup without forcing the user to remember all the low-level details.

## Main behavior

- links profile-specific `.gitconfig` files from a managed directory such as `~/.files/.gitenv`
- clears stale VS Code Git askpass environment variables when the IPC handle is no longer valid
- checks for `pass` entries and prints guidance when GitHub credential storage is configured via password-store
- selects a default merge tool such as `nvimdiff`, `vimdiff`, or `meld` when no global merge.tool is set
- provides helper commands for saving GitHub credentials to `pass`
- syncs identity settings when the repo context changes

## Idea behind the module

This module is about reducing shell friction for Git-heavy workflows. Instead of forcing a single global Git setup for every environment, it keeps configuration profile-aware and environment-aware while still giving the user a clean default path.

## Recommended workflow

```bash
source ~/.zshrc
cd ~/project
git config --global --list | grep -E 'user|merge|credential'
git-pass-save origin
```

The usual workflow is to allow the shell to pick up the correct profile config, then use the helper commands only when GitHub auth or merge-tool setup needs to be refreshed.

## Setup

```bash
# keep per-profile git configs in ~/.files/.gitenv/<profile>
# for example:
# ~/.files/.gitenv/default/.gitconfig
# ~/.files/.gitenv/default/.gitconfig-personal
# ~/.files/.gitenv/default/.gitconfig-work

source ~/.zshrc
```

Once the profile directory is present, the module automatically symlinks the relevant configs into the home directory and configures the default merge tool when available.
