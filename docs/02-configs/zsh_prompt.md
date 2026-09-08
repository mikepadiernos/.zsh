# Prompt configuration

This document covers the zsh prompt configuration loaded from `.zsh/configs/.zsh_prompt`.

## Purpose

The prompt system defines the terminal status line used throughout the shell. It is responsible for:

- rendering the current working directory in a compact form
- showing git branch and repo context
- styling exit status and job state
- supporting prompt colors and glyph configuration
- enabling async git updates and magic-enter actions

## Main settings

The prompt is configured with several environment variables and defaults:

- `ZSH_PROMPT_LAYOUT` — prompt layout mode, default `singleline_verbose`
- `ZSH_PROMPT_RELATIVE_PATH` — path rendering mode, default `adaptive`
- `ZSH_PROMPT_CURSOR` — cursor style, default `terminal`
- `ZSH_PROMPT_GLYPH_MODE` — `unicode` or `ascii`
- `ZSH_PROMPT_SYMBOL` / `ZSH_PROMPT_ARROW_SYMBOL` — override glyphs directly
- `ZSH_PROMPT_SYMBOL_ASCII` / `ZSH_PROMPT_SYMBOL_UNICODE`
- `ZSH_PROMPT_ARROW_ASCII` / `ZSH_PROMPT_ARROW_UNICODE`
- `ZSH_PROMPT_DISABLE_RETURN_CODE` — disables exit-code display when set to true
- `ZSH_PROMPT_ENABLE_STATUS_STYLING` — toggles status styling
- `ZSH_PROMPT_USE_THEME_COLORS` — use theme colors if available
- `ZSH_PROMPT_ASYNC_GIT` — enable async git rendering when true
- `ZSH_PROMPT_MAGIC_ENTER_PRETTY` — enable magic-enter helper behavior
- `ZSH_PROMPT_MAGIC_ENTER_COOLDOWN_SECONDS` — rate-limit empty-enter actions
- `ZSH_PROMPT_LEFT_PREFIX` / `ZSH_PROMPT_RIGHT_PREFIX`
- `ZSH_PROMPT_LEFT_PREFIX_FUNCTION` / `ZSH_PROMPT_RIGHT_PREFIX_FUNCTION`

## How it works

The prompt system does the following at startup:

1. initializes the prompt variables with defaults
2. registers the async git worker and magic-enter action pipeline
3. determines whether theme colors are available
4. computes the effective symbol and arrow glyphs
5. renders prompt segments for path, venv, git, jobs, and exit status

The prompt logic is intentionally built to be lightweight and to degrade gracefully when a theme or async helper is unavailable.

## Typical usage

To inspect or adjust the prompt:

```bash
print -r -- "$ZSH_PROMPT_LAYOUT"
export ZSH_PROMPT_LAYOUT=singleline
export ZSH_PROMPT_GLYPH_MODE=ascii
exec zsh
```

Useful adjustments:

```bash
export ZSH_PROMPT_ASYNC_GIT=false
export ZSH_PROMPT_MAGIC_ENTER_PRETTY=false
export ZSH_PROMPT_LEFT_PREFIX='dev'
```

## Step-by-step guidance

### 1. Check the active settings

```bash
env | grep '^ZSH_PROMPT'
```

### 2. Switch to a different layout

```bash
export ZSH_PROMPT_LAYOUT=singleline
exec zsh
```

### 3. Use ASCII symbols for compatibility

```bash
export ZSH_PROMPT_GLYPH_MODE=ascii
exec zsh
```

### 4. Disable async git prompts when needed

```bash
export ZSH_PROMPT_ASYNC_GIT=false
exec zsh
```

### 5. Override the prompt glyphs manually

```bash
export ZSH_PROMPT_SYMBOL='>'
export ZSH_PROMPT_ARROW_SYMBOL='->'
exec zsh
```

## Recommended workflow

For a normal shell session:

```bash
source ~/.zshrc
zsh_themes --list
zsh_themes --theme minimal
```

This gives you a quick way to inspect the prompt, choose a theme, and test the result without editing the source config directly.

## Troubleshooting

If the prompt looks wrong:

- confirm the theme setup succeeded
- test whether async git rendering is enabled
- verify the shell is not overriding `PS1` later in startup
- check whether a custom theme defines colors and whether `ZSH_PROMPT_USE_THEME_COLORS` is set to `true`

## Description

The prompt configuration is one of the core user experience pieces in this project. It is intentionally separate from shell logic so the prompt can be tuned, switched, or debugged without affecting plugin management or project health checks.
