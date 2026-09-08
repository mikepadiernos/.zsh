# Core zsh runtime functionality

This document covers the core runtime behaviors that make the shell dependable, quiet, and project-aware. It complements the startup, module, plugin, theme, and completion documents by explaining the shell primitives the rest of the runtime relies on.

## Purpose

The zsh runtime in this project is designed to behave like a thin but capable environment layer. It does not try to do everything eagerly. Instead, it sets the machine context once, exposes a few reusable shell helpers, and then sources the config fragments that enable the actual features used by the current session.

The important design rule is simple: keep startup quiet, predictable, and safe.

## Core shell environment

The root shell entrypoint in [.zshrc](../../.zshrc) establishes the basic runtime environment before any project logic is loaded.

It sets values such as:

- `LC_ALL` for UTF-8 output
- `SHELL` to the active zsh binary
- `EDITOR` to `nvim`
- `FILES` to `$HOME/.files`
- runtime paths such as `$ZSH`, `$ZSH_CONFIGS`, `$ZSH_MODULES`, `$ZSH_PLUGINS`, and `$ZSH_THEMES`

These variables give the rest of the runtime a stable contract: every module, theme, config, and plugin can assume the repo path layout and the basic runtime root are already defined.

## Path management

The runtime uses zsh’s `path` and `PATH` deduplication pattern:

```zsh
typeset -U path PATH
```

This keeps later path additions from duplicating previously discovered locations, especially important when `mise`, `brew`, local bins, and project toolchains are layered together.

The startup adds common per-user locations such as:

- `$HOME/.local/bin`
- `$HOME/.local/share/pnpm`
- cargo and go bin directories
- other project-local tool paths

This is intentionally minimal and conservative. It avoids speculative global installation and favors the shell environment being explicit and reproducible.

## Startup guards and quiet behavior

The bootstrap layer in [configs/.zsh_bootstrap](../../configs/.zsh_bootstrap) introduces the core runtime guard functions:

- `source_if_exists`
- `zsh_startup_is_truthy`
- `zsh_startup_should_log`
- `zsh_startup_log`
- `_zsh_startup_should_disable_mise_tools`

These helpers ensure the shell does not emit noisy output in non-interactive, quiet, or root/server contexts. The runtime treats startup noise as a bug, not a feature, which is particularly important for VPS, WSL, and automation-friendly environments.

This is the root cause of the project’s startup discipline: the shell should degrade gracefully and stay quiet when it is running in a constrained environment.

## Helper functions

The bootstrap layer adds a small library of reusable zsh helpers used by later startup files.

### `source_if_exists`

This wrapper checks whether a file exists before sourcing it. It is used widely to keep the shell from failing when optional config files or feature modules are not present.

### `eval_if_command_exists`

This checks for a command name before evaluating a command fragment. It is useful for dynamically enabling tool integrations only when the underlying CLI is actually present.

### `source_cached_init`

This caches tool initialization output in `$XDG_CACHE_HOME/zsh` or `$HOME/.cache/zsh` and then sources the cached result. It is used for tools such as `fzf` and `zoxide` so they can initialize quickly without re-running expensive startup commands every shell session.

This pattern is part of the runtime’s philosophy: prefer laziness and reuse over redundant work.

## Interactive shell behavior

The runtime checks whether the shell is interactive before enabling certain behaviors:

```zsh
[[ -o interactive ]] || return 1
```

This matters because some shell support features should only exist in interactive terminals, while the project also wants the runtime to remain safe in scripts and automation contexts.

For example, startup logging and performance profiling are gated behind interactive detection and startup flags, so they do not leak into CI or other non-user shells.

## Performance profiling

The bootstrap layer also contains a lightweight startup profiling system:

- `zsh_startup_profile_now_ms`
- `zsh_startup_profile_record`
- `zsh_startup_profile_report`

These are only enabled when `ZSH_STARTUP_PROFILE=true` and the shell is interactive. They help measure which file or helper is taking the most time during startup without being active by default.

This gives the project a simple, low-friction method to reason about slow shell startups when debugging or tuning runtime performance.

## Ordered boot sequence

The runtime loads the core config fragments in a strict order through [configs/.zsh_load_configs](../../configs/.zsh_load_configs) and [configs/.zsh_load_modules](../../configs/.zsh_load_modules). The bootstrap file then performs final tool initialization steps:

1. load config files
2. load module helpers
3. initialize common tool wrappers such as `fzf` and `zoxide`
4. initialize `atuin` when present
5. print the startup profile if profiling is enabled

This is a clean divide between shell foundation, helper modules, and feature-specific runtime logic.

## Recommended workflow

The preferred rhythm for working with the runtime is:

```bash
source ~/.zshrc
zsh_health
zsh_plugins --check-forks --dry-run
```

This validates:

- the runtime loads cleanly
- the environment is consistent
- the project context is recognized
- the managed plugin stack has not drifted

## Where the core logic lives

The core runtime behavior is implemented in the following places:

- [.zshrc](../../.zshrc) — root shell entrypoint and environment setup
- [configs/.zsh_bootstrap](../../configs/.zsh_bootstrap) — shared helper library and startup guards
- [configs/.zsh_load_configs](../../configs/.zsh_load_configs) — config ordering and source plan
- [configs/.zsh_load_modules](../../configs/.zsh_load_modules) — module ordering and lazy feature activation

## Description

The core zsh runtime is intentionally thin, quiet, and explicit. It defines the environment, keeps startup safe, exposes reusable helper functions, and leaves feature-specific behavior to the config and module layers. That separation is what makes the shell stable, debuggable, and easy to extend.
