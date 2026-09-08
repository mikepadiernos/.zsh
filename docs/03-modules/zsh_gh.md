# GitHub CLI module

This document covers the GitHub CLI setup in [modules/.zsh_gh](../../modules/.zsh_gh).

## Purpose

The GitHub CLI module ensures `gh` is available when the current project is a git repository and can install it via `mise` when the environment allows it. It also registers the completion logic for the shell.

## Main behavior

- detects whether the current directory is inside a Git repository
- installs `gh` automatically via `mise` only when shell startup allows installs
- registers completion for `gh` if the binary is available
- stays silent when the CLI is absent and the startup policy blocks installation

## Idea behind the module

This module is a small but useful convenience for developers who live in GitHub-centric workflows. It reduces the friction of missing tooling without forcing installation in every shell startup.

## Recommended workflow

```bash
source ~/.zshrc
cd ~/repo
gh auth login
gh repo view
gh pr list
```

When the project is a git repo and `gh` is installed, the developer gets a fully integrated CLI experience without manual intervention.

## Setup

```bash
export ZSH_STARTUP_ALLOW_INSTALLS=true
source ~/.zshrc

# or install manually
mise install gh
mise use --global gh
```

The module is intentionally conservative: it only installs when the runtime policy allows it, which keeps shell startup quiet and predictable.
