# Theme loading

This document explains how the shell theme system is selected and applied during startup.

## Source of truth

The theme loader is defined in [configs/.zsh_themes](../../configs/.zsh_themes), and the theme files live in [themes](../../themes).

## How themes are loaded

The shell calls:

```zsh
zsh_themes --theme "${ZSH_THEME:-none}"
```

from the theme loader. The helper resolves the theme file name under the `$ZSH_THEMES` directory and sources the matching `.zsh-theme` file if it exists.

Themes are loaded before the prompt is fully rendered so the prompt can use the selected colors and glyphs immediately.

## Supported behavior

The loader accepts:

- `--theme NAME`
- `--list`
- `--help`

It also supports the common `none` placeholder, which disables theme loading when needed.

## Theme files

The runtime expects a theme file to exist in [themes](../../themes) under the naming convention `NAME.zsh-theme` and then sources it through the theme loader in [configs/.zsh_themes](../../configs/.zsh_themes).

The repo’s current theme directory is intentionally minimal and may contain or omit theme sources depending on the machine or checkout. The loader itself is the source of truth, and the prompt behavior is still defined by [configs/.zsh_prompt](../../configs/.zsh_prompt).

## Recommended workflow

```bash
source ~/.zshrc
zsh_themes --list
zsh_themes --theme minimal
```

This is usually the safest first step when you want to test a new prompt layout or fall back to a minimal style.

## Troubleshooting

If the theme is not appearing:

- confirm the theme file exists in [themes](../../themes)
- confirm the desired theme name matches the filename exactly
- verify the loader is running in the same shell session and has not been overridden later in startup
- check the prompt configuration in [configs/.zsh_prompt](../../configs/.zsh_prompt)

## Description

The theme layer is intentionally very thin. It handles selection and load-time injection, while the prompt configuration remains the place for details about layout, glyphs, and prompt rendering behavior.
