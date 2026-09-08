# Bootstrap and shell startup

This document explains how the runtime boots and why the startup order is structured the way it is.

## Source of truth

The startup flow begins in [.zshrc](../../.zshrc), then continues through the bootstrap helpers in [configs/.zsh_bootstrap](../../configs/.zsh_bootstrap), [configs/.zsh_load_configs](../../configs/.zsh_load_configs), and [configs/.zsh_load_modules](../../configs/.zsh_load_modules).

## Startup flow

The boot process is intentionally simple and conservative:

1. [.zshrc](../../.zshrc) sets the runtime environment, `PATH`, and the repo root variables.
2. it sources [configs/.zsh_bootstrap](../../configs/.zsh_bootstrap).
3. the bootstrap file defines shared helpers such as `source_if_exists`, startup logging, and cached init helpers.
4. it then loads the config group and module group in a controlled order.
5. after that it initializes helper tools such as `fzf`, `atuin`, and `zoxide`.
6. the prompt and health checks are loaded after the core environment has stabilised.

## Why the ordering matters

The order is designed to make the shell quiet and predictable:

- `PATH` and repo variables are set before anything else loads
- `zsh_startup_is_truthy` and related guards keep noisy behavior out of non-interactive or quiet shells
- config files are loaded before the heavier runtime helper modules
- modules are loaded after the config layer so they can rely on `ZSH_*` variables and path setup
- `mise` is intentionally activated late, so its binary should win over brew or system toolchains without fighting earlier PATH setup

## Config and module load order

The shell loads config files from [configs/.zsh_load_configs](../../configs/.zsh_load_configs):

- `.zsh_themes`
- `.zsh_plugins`
- `.zsh_bindkeys`
- `.zsh_aliases`
- `.zsh_atuin`
- `.zsh_history`
- `.zsh_go`
- `.zsh_completions`
- `.zsh_prompt`
- `.zsh_health`
- `.zsh_setup`
- `.zsh_tools`

The shell then loads modules from [configs/.zsh_load_modules](../../configs/.zsh_load_modules):

- `.zsh_wsl`
- `.zsh_homebrew`
- `.zsh_gpg`
- `.zsh_drush`
- `.zsh_composer`
- `.zsh_python`
- `.zsh_git`
- `.zsh_gh`
- `.zsh_node`
- `.zsh_docker`
- `.zsh_table`
- `.zsh_nextcloud`
- `.zsh_nocsd`
- `.zsh_nvidia`
- `.zsh_mise`

The module ordering is not accidental: `mise` is placed last so its shims and PATH entries can override older toolchain installs in a consistent way.

## Concepts

### Quiet startup

The runtime prefers a calm shell. It avoids aggressive installs during shell startup, uses dry-run and explicit update actions for maintenance, and keeps defaults safe in root or server-style environments.

### Runtime-first behavior

Most helpers are lightweight and lazy. They do not run broad startup installs or deep environment checks unless the current directory or current project context requires them.

### Explicit maintenance

Package updates, plugin installs, and repo refreshes are treated as deliberate tasks instead of hidden shell side effects. That keeps the shell stable and easier to reason about.

## Recommended workflow

```bash
cd ~/.zsh
source ~/.zshrc
zsh_plugins --check-forks --dry-run
zsh_health
```

For a fresh setup or a machine rebootstrap, the usual path is:

```bash
git clone <your-zsh-runtime-url> ~/.zsh
cd ~/.zsh
source ~/.zshrc
zsh_plugins --install
zsh_setup --setup-all
zsh_health
```

This sequence loads the runtime, resolves the managed plugin set, prepares the local runtime config, and validates the current environment before more invasive maintenance is applied.

## Troubleshooting

If the runtime is behaving unexpectedly:

- verify the bootstrap path with `source ~/.zshrc`
- check whether a config file was skipped because it does not exist
- inspect the startup log and zsh environment variables
- confirm that the project context matches the expected module behavior

## Description

The bootstrap layer is the foundation of the entire shell. It gives the runtime a clear start-up contract: establish environment variables, source config fragments, enable helpful modules, and only then do the heavier user-facing pieces such as prompt, completions, and health checks.
