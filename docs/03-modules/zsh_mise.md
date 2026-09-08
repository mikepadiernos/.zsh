# Mise module

This document covers the `mise` bootstrap and shell activation in [modules/.zsh_mise](../../modules/.zsh_mise).

## Purpose

The Mise module is responsible for ensuring the runtime can install and activate toolchains without making shell startup noisy. It handles the conservative bootstrap path and ensures a local `mise` version can be used when appropriate.

## Main behavior

- disables tool installation for root shells or intentionally quiet startup contexts
- checks whether `mise` is already installed
- runs a local setup script if it exists and startup allows installs
- adds `$HOME/.local/bin` to `PATH` when a local `mise` binary is available
- logs the presence of `mise` and then loads the plugin from `zsh-mise`

## Idea behind the module

The runtime prefers `mise` as the first toolchain manager and avoids aggressive automatic installs during startup. This fits the project-wide philosophy of quiet, predictable shell behavior with explicit maintenance steps.

## Recommended workflow

```bash
source ~/.zshrc
mise --version
mise install node
mise use --global node@lts
```

The usual pattern is to treat `mise` as the toolchain coordinator and only install tools through explicit commands or controlled setup routines.

## Setup

```bash
export ZSH_STARTUP_ALLOW_INSTALLS=true
source ~/.zshrc

# or run the setup script explicitly
bash ~/.files/scripts/setup-mise.sh
```

This keeps the project consistent with the goal of safe shell startup: automatic installs are opt-in, while static shell configuration remains quiet by default.
