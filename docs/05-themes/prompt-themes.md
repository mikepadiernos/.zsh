# Prompt themes

This document covers the visual prompt/theme layer in [../../themes](../../themes).

## Theme loader behavior

The runtime loads a theme by name through [../../configs/.zsh_themes](../../configs/.zsh_themes). The loader supports theme names such as `minimal` or `typewritten` and expects a matching `.zsh-theme` file in the theme directory.

The actual theme files present in the repo may vary by checkout. The runtime contract is the important part: any valid `NAME.zsh-theme` file under the theme directory can be selected and sourced during startup.

## Purpose

Themes define the visible shell prompt, including:

- path and status rendering
- git status layout
- prompt colors and glyphs
- theme-specific prompt styling

## Typical usage

```bash
zsh_themes --list
zsh_themes --theme minimal
zsh_themes --theme typewritten
```

## Recommended workflow

Use a simple theme first and switch only when the prompt needs a specific style:

```bash
source ~/.zshrc
zsh_themes --list
zsh_themes --theme minimal
```

## Description

The theme layer is intentionally lightweight. It changes how the prompt looks without changing how the shell behaves, which keeps the runtime easy to maintain and easier to diagnose when a prompt issue appears.
