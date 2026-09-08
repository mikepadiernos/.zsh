# Plugin loading

This document describes how the plugin set is discovered, installed, and loaded in the shell runtime.

## Source of truth

The plugin system is driven by [configs/.zsh_plugins](../../configs/.zsh_plugins) and the managed repo list in [plugins/git_repos.txt](../../plugins/git_repos.txt).

## How plugin loading works

The plugin loader does a few important things up front:

- sets the plugin dependency install policy variables
- creates the completion cache path when the shell is interactive
- sets `compinit` style arguments for the completion system
- defines helper functions for repo URL lookup, plugin file resolution, and dependency checks

It then resolves each plugin checkout, typically by looking for files such as `.plugin.zsh` inside the matching plugin directory and sourcing them when present.

## Behavior and safety

The plugin layer is intentionally careful about startup safety:

- it respects root shells and quiet configuration
- it avoids broad install churn unless dependency install policy is enabled
- it checks for missing command dependencies before installing them
- it prefers `mise` before `brew` whenever a matching package exists
- it uses dry-run or preview options for drift detection and update review

## Dependency and install strategy

The runtime checks whether a plugin dependency is missing and then installs it using the safest known path. In practice this means:

- use `mise` when the package is available there
- fall back to `brew` for non-root users only when needed
- fall back to package manager installs or the repo-managed install path when the environment allows it

This keeps plugin setup safe without becoming a hidden side effect of shell startup.

## Recommended workflow

```bash
source ~/.zshrc
zsh_plugins --check-forks --dry-run
zsh_plugins --install
```

This sequence is the standard review/repair pattern: inspect plugin drift first, then install or update the managed set only when the preview is acceptable.

## Troubleshooting

If plugin behavior fails:

- confirm the repo name appears in [plugins/git_repos.txt](../../plugins/git_repos.txt)
- inspect whether the plugin checkout exists under [plugins](../../plugins)
- verify that the plugin file is named as `.plugin.zsh` and is discoverable
- run the fork check and dry-run commands before changing the plugin manifest

## Description

The plugin layer is the runtime’s managed extension system. It provides reproducibility, dependency safety, and a clear review path before any plugin update or install happens.
