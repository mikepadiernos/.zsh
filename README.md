# Zsh Setup Guide

This folder contains a modular Zsh setup focused on fast startup, lazy loading, and project-aware behavior.
It is an opinionated and advanced shell environment with many quality-of-life features, designed to stay OS-agnostic across Linux, macOS, and WSL-friendly workflows.

## Fresh Clone Quick Start

Run these commands on a new machine after cloning to `~/.zsh`:

1. `zsh_plugins --install`
2. `source ~/.zshrc`
3. `tools --update --dry-run`

User detection and portability:
- User-specific behavior is dynamic and avoids hard-coded usernames.
- Runtime user defaults are derived from `ZSH_RUNTIME_USER` and then `USER`.
- Pass entry and git identity behavior can be customized with environment variables (see sections below).

## Load Order

1. `.zsh/.zshrc`
2. `.zsh/configs/.zsh_bootstrap`
3. `.zsh/configs/.zsh_load_configs`
4. `.zsh/configs/.zsh_load_modules`

Bootstrap also caches generated init scripts for selected tools to improve startup time.

## Features and Functionalities

### 1) Themes

Provided by `.zsh/configs/.zsh_themes`.

Command:
- zsh_themes [--theme NAME|-t NAME] [--list|-l] [--help|-h]

Options:
- --theme NAME, -t NAME: set and load a theme
- --theme=NAME: same as above
- --list, -l: list available themes
- --help, -h: show help

Theme files are loaded from `.zsh/themes` using `NAME.zsh-theme`.

### 2) Prompt Engine

Provided by `.zsh/configs/.zsh_prompt`.

Main configurable variables:
- ZSH_PROMPT_LAYOUT: singleline | multiline | pure | pure_verbose | half_pure | singleline_verbose
- ZSH_PROMPT_RELATIVE_PATH: adaptive | git | home
- ZSH_PROMPT_CURSOR: terminal | block | beam
- ZSH_PROMPT_GLYPH_MODE: unicode | ascii
- ZSH_PROMPT_SYMBOL and ZSH_PROMPT_ARROW_SYMBOL: override prompt glyphs directly
- ZSH_PROMPT_SYMBOL_ASCII, ZSH_PROMPT_SYMBOL_UNICODE: fallback symbols
- ZSH_PROMPT_ARROW_ASCII, ZSH_PROMPT_ARROW_UNICODE: fallback arrows
- ZSH_PROMPT_DISABLE_RETURN_CODE: true | false
- ZSH_PROMPT_ENABLE_STATUS_STYLING: true | false
- ZSH_PROMPT_USE_THEME_COLORS: true | false
- ZSH_PROMPT_SYMBOL_JOBS_COLOR: color name used when background jobs exist
- ZSH_PROMPT_ASYNC_GIT: true | false (async git context)
- ZSH_PROMPT_MAGIC_ENTER_PRETTY: true | false
- ZSH_PROMPT_MAGIC_ENTER_COOLDOWN_SECONDS: integer cooldown for empty-enter actions
- ZSH_PROMPT_LEFT_PREFIX and ZSH_PROMPT_RIGHT_PREFIX: static prefixes
- ZSH_PROMPT_LEFT_PREFIX_FUNCTION and ZSH_PROMPT_RIGHT_PREFIX_FUNCTION: dynamic prefix functions

Behavior:
- Async git status/branch rendering when supported.
- Optional Magic Enter action pipeline (empty Enter key can run dashboard actions).

### 3) Completions

Provided by `.zsh/configs/.zsh_completions`.

Highlights:
- Uses compinit with cache dump at `~/.cache/zsh/zcompdump-<zsh_version>`.
- Uses non-interactive compinit startup arguments (`-i`) to avoid security prompts, with `-u` enabled for root shells.
- Enables lazy completion generation for heavy CLIs (docker, kubectl, helm, argocd, az, etc.).
- Adds custom completion for:
  - zsh_themes
  - zsh_setup
  - zsh_python

Related variables:
- ZSH_DISABLE_COMPFIX=true
- ZSH_COMPDUMP path is set automatically.

### 4) Python Auto-Venv

Provided by `.zsh/modules/.zsh_python`.

Command:
- zsh_python [--enable-auto-venv|--disable-auto-venv|--deactivate|--status|--help]

Options:
- --enable-auto-venv: enable project venv auto-activation
- --disable-auto-venv: disable auto-activation and deactivate current venv
- --deactivate: deactivate current venv
- --status: print current mode
- --help, -h: usage

Related variables:
- ZSH_PYTHON_AUTO_VENV: true | false
- ZSH_PYTHON_STATUS_DEBOUNCE_SECONDS: debounce interval

### 5) Node/NVM Lazy Activation

Provided by `.zsh/modules/.zsh_node`.

Behavior:
- Detects Node projects by `package.json`, `.nvmrc`, `.node-version`, lockfiles.
- Loads NVM lazily only when needed.
- Detects mise-managed Node configs and surfaces compatibility hints.

Related variables:
- NVM_DIR
- ZSH_NODE_STATUS_DEBOUNCE_SECONDS

### 6) Git Environment and Identity Automation

Provided by `.zsh/modules/.zsh_git`.

Commands:
- git-pass-save [remote]
- git-env-sync

Behavior:
- Links gitenv profiles to:
  - ~/.gitconfig
  - ~/.gitconfig-personal
  - ~/.gitconfig-work
- Auto-selects merge tool if unset.
- Clears stale VS Code askpass socket environment when broken.
- Syncs local repo identity based on path/remote heuristics.

Related variables:
- GITENV_PROFILE
- GIT_SETUP_VERBOSE
- ZSH_GIT_SYNC_DEBOUNCE_SECONDS
- ZSH_GIT_SYNC_ON_PRECMD: true | false
- ZSH_GIT_DEFAULT_NAME / ZSH_GIT_DEFAULT_EMAIL
- ZSH_GIT_PERSONAL_NAME / ZSH_GIT_PERSONAL_EMAIL
- ZSH_GIT_WORK_NAME / ZSH_GIT_WORK_EMAIL

### 7) Toolchain Update Orchestrator

Provided by `.zsh/configs/.zsh_tools`.

Command:
- tools --update [flags]

List actions:
- tools --list-tools
- tools --list-links

Setup action:
- tools --setup-links
- tools --setup-links --dry-run

Main flags:
- --list-tools
- --list-links
- --setup-links
- --mise-only
- --brew-only
- --system-only
- --no-brew
- --no-mise
- --no-paru
- --no-grub
- --no-flatpak
- --no-plasma
- --plasma-strict-rate-limit
- --no-firmware
- --no-vscode
- --dry-run
- --help, -h

Behavior:
- Orchestrates updates across mise, brew, system packages, grub refresh, flatpak, plasmoids, firmware, and VS Code extensions.
- Linux package-manager update stages are auto-gated by OS/tool detection; on macOS or unsupported Linux package-manager setups, those stages are skipped.
- Symlink setup can link dot-config entries from `~/.files` into `~` with safe backup/relink behavior.
- Listing mode can show available managed tools and the current custom symlink map/status.
- list-links also reports complex nested symlinks from within each config folder when they resolve outside the folder or use absolute targets.

Companion command:
- plasmoids [--dry-run] [--prune-retired] [--strict-rate-limit]

### 8) Plugin Install/Update and Fork Sync Checks

Provided by `.zsh/configs/.zsh_tools`.

Command:
- zsh_plugins [--install] [--update] [--check-forks] [--no-fetch] [--dry-run] [--repos-file=PATH] [--plugins-dir=PATH]

Alias:
- zsh-plugins

Actions:
- --install: clone missing plugin repos listed in `.zsh/plugins/git_repos.txt`
- --update: fetch and fast-forward pull plugin repos
- --check-forks: warn when forked plugin repos are missing `upstream` or behind upstream

Startup default:
- Missing plugin repos are not auto-cloned during shell init unless `ZSH_PLUGIN_AUTO_INSTALL_REPOS=true` is set.
- Recommended first-run bootstrap: `zsh_plugins --install`.

Additional startup toggles:
- `ZSH_PLUGIN_AUTO_INSTALL_REPOS=false` by default.
- `ZSH_PLUGIN_AUTO_INSTALL_DEPENDENCIES=false` by default.

Options:
- --no-fetch: skip fetch before checks/updates
- --dry-run: print commands only
- --repos-file=PATH: override plugin repo list
- --plugins-dir=PATH: override plugin directory

User-related overrides:
- `ZSH_RUNTIME_USER`: explicit runtime username override.
- `ZSH_TOOLS_SUDO_PASS_ENTRY`: primary pass entry path for `tools` sudo flow.
- `ZSH_TOOLS_SUDO_PASS_ENTRY_ALT`: alternate pass entry path for `tools` sudo flow.

Fork sync warnings:
- If `origin` points to a fork namespace and `upstream` is missing, a warning is printed.
- If both remotes exist and `origin` is behind `upstream` on default branches, a warning is printed with sync guidance.

Configurable fork detection (host-agnostic):
- `ZSH_PLUGINS_FORK_OWNERS`: comma-separated owner list treated as fork owners.
- `ZSH_PLUGINS_FORK_OWNER_REGEX`: optional owner regex matcher.
- `ZSH_PLUGINS_FORK_URL_REGEX`: optional full remote URL regex matcher.
- Default remains `michaelpadiernos-forks` for backward compatibility.

Examples:
- ZSH_PLUGINS_FORK_OWNERS='my-forks,team-forks' zsh_plugins --check-forks
- ZSH_PLUGINS_FORK_OWNER_REGEX='(fork|forks)$' zsh_plugins --check-forks

Suggested fork sync flow:
- git -C ~/.zsh/plugins/<plugin> remote add upstream <original-repo-url>
- git -C ~/.zsh/plugins/<plugin> fetch upstream
- git -C ~/.zsh/plugins/<plugin> merge --ff-only upstream/main
- git -C ~/.zsh/plugins/<plugin> push origin HEAD

### 9) Shell Setup Helper

Provided by `.zsh/configs/.zsh_setup`.

Command:
- zsh_setup --setup-all [path/to/git_repos.txt] [python-executable]
- zsh_setup --setup-venv [python-executable]
- zsh_setup --pull-repos [path/to/git_repos.txt]

Alias:
- zsh-setup

Behavior:
- Clones repo lists and creates local project venv with required bootstrap packages.
- Bootstraps `mise` when missing, then runs tooling install via `tools --update --mise-only`.
- Installs zsh plugin repos via `zsh_plugins --install` when available.
- Applies symlink setup via `tools --setup-links`.

### 10) Aliases and Wrappers

Provided by `.zsh/configs/.zsh_aliases`.

General aliases:
- li (list with icons)
- lzd (lazydocker)
- lzg (lazygit)
- nmt (neomutt)
- vim, vm (nvim)
- yz (yazi)

Functions/wrappers:
- sudo: pass-backed askpass wrapper with safe bypass for existing stdin/askpass flags
- sudo pass entry default: `local/sudo/<detected-user>` (override with `ZSH_SUDO_PASS_ENTRY`)
- lazygit: clears VS Code askpass env and runs git-env-sync before launch
- yazi: VS Code-aware environment adjustments for renderer compatibility
- nowrap / wrapon: terminal line wrapping toggles

Nushell-inspired table listing (from `.zsh/modules/.zsh_table`):
- `lll`: canonical table-listing command.
- `nls`: compatibility alias for `lll` kept for older workflows.
- `lstable`: alias for `lll`.
- `lll --fast`: quick pass through `eza --long --grid` when `eza` is installed; otherwise it falls back to the rich table renderer.
- `lll --encoded`: Unicode box-drawing table (default style).
- `lll --ascii`: ASCII-only table borders for limited terminals.
- `lll --all` / `lll --no-all`: include or exclude hidden entries.
- `lll --sort=size|modified|both --asc|--desc`: sort by size, modified time, or both, ascending or descending.
- `ZSH_NU_TABLE_STYLE`: default render style (`encoded` or `ascii`).
- `ZSH_NU_TABLE_MIN_WIDTH_PERCENT`: encoded mode minimum width target as a percentage of terminal width (default `50`); table grows wider when content requires it.
- If Nushell (`nu`) is installed and encoded mode is active, output uses Nushell table rendering; otherwise the local renderer is used.
- Symlinks show inline as `name -> target` and are highlighted in cyan in the local renderer; symlink-containing listings fall back to the local renderer so the target stays visible.

Credits:
- The layout and behavior are inspired by Nushell's `ls | table` output style, adapted into a zsh-native renderer for this runtime.
- The `nls` name is retained as a compatibility alias; the project's canonical command is `lll`.

Example output (`lll --ascii`):

```text
+----+-----------+------+--------+------------------+
| #  | name      | type | size   | modified         |
+----+-----------+------+--------+------------------+
| 0  | configs   | dir  | 320 B  | 2026-09-06 21:14 |
| 1  | README.md | file | 17 KiB | 2026-09-06 20:20 |
| 2  | plugins -> ../plugins | link | 4 B | 2026-09-06 20:20 |
+----+-----------+------+--------+------------------+
```

Example output (`lll --encoded`):

```text
╭────┬───────────┬──────┬────────┬──────────────────╮
│ #  │ name      │ type │ size   │ modified         │
├────┼───────────┼──────┼────────┼──────────────────┤
│ 0  │ configs   │ dir  │ 320 B  │ 2026-09-06 21:14 │
│ 1  │ README.md │ file │ 17 KiB │ 2026-09-06 20:20 │
│ 2  │ plugins -> ../plugins │ link │ 4 B │ 2026-09-06 20:20 │
╰────┴───────────┴──────┴────────┴──────────────────╯
```

Conditional aliases:
- fileu and filec when FileCentipede app dir exists

### 11) Desktop and Platform Helpers

NVIDIA offload from `.zsh/modules/.zsh_nvidia`:
- nvidia-offload <command>
- steam-nvidia [args]
- optional steam alias in GUI sessions

GTK CSD compatibility from `.zsh/modules/.zsh_nocsd`:
- Dynamically applies/removes LD_PRELOAD for GUI apps that need gtk-nocsd
- Applies per-command bypass aliases from blacklist file:
  - ~/.config/gtk-nocsd-blacklist

WSL integration from `.zsh/modules/.zsh_wsl`:
- copy/paste aliases via pbcopy/pbpaste in WSL
- Ctrl+V widget support when available

GPG helper from `.zsh/modules/.zsh_gpg`:
- sets GPG_TTY
- optional one-shot passphrase preset script integration

Composer/Drush helpers:
- Composer status hint in `.zsh/modules/.zsh_composer`
- DDEV-aware Drush command shortcuts in `.zsh/modules/.zsh_drush`:
  - den, dun, dcr, dcri, dcrx

## Recommended Workflow

### Prerequisites

Required base:
- zsh
- git
- neovim (or adjust EDITOR)
- ripgrep
- curl

Required repository layout:
- this zsh repo must live at `~/.zsh`
- a separate `~/.files` directory is required
- `FILES` defaults to `~/.files`; app-specific configs are expected under `~/.files` (for example `.atuin`, `.lazygit`, `.yazi`, `.qute`, `.copyq`, `.vscode`, `.gtk-nocsd`)

Plugin repository tracking model:
- Plugin directories under `~/.zsh/plugins` are intentionally treated as local clones.
- Git tracking keeps `plugins/git_repos.txt` (source of truth) and `plugins/.gitignore`; plugin repo folders are ignored.
- Bootstrap missing plugin clones with `zsh_plugins --install`.

Required `~/.files` contents for full setup behavior:
- `~/.files/.fzf`
- `~/.files/.vscode/settings.json`
- `~/.files/.vscode/keybindings.json`
- `~/.files/.atuin`
- `~/.files/.atuin/data`
- `~/.files/.qute`
- `~/.files/.copyq`
- `~/.files/.yazi`
- `~/.files/.lazygit`
- `~/.files/.lazydocker`
- `~/.files/.gtk-nocsd/config/gtk-nocsd-blacklist`
- `~/.files/.gtk-nocsd/applications/filec.desktop`
- `~/.files/.gtk-nocsd/bin/gtk-nocsd-sync-shims`
- `~/.files/.gtk-nocsd/bin/gtk-nocsd-run`
- `~/.files/.gtk-nocsd/shims/filecentipede`
- `~/.files/.gtk-nocsd/shims/filec`
- `~/.files/.gtk-nocsd/shims/fileu`

Core runtime tooling for this shell:
- mise
- direnv
- zoxide
- atuin
- fzf
- eza
- fd
- bat
- jq

Container and DevOps flows:
- docker CLI
- docker compose v2 (or legacy `docker-compose`)
- colima (required for the colima-integrated docker runtime flow)
- lazydocker
- kubectl
- helm
- argocd
- azure-cli
- gh

Update orchestration and package backends:
- brew (optional, non-root)
- paru or yay or pacman (Arch)
- dnf5 or dnf or yum (Fedora)
- apt (Ubuntu/Debian)
- flatpak (optional)
- fwupdmgr (optional)
- kpackagetool6 and curl (plasmoids flow)

Credential-backed flows:
- pass
- gpg and gpg-agent

Note:
- `pass` is only required for package-manager sudo automation when a supported Linux system-package stage is actually executed.

Ecosystem-specific helpers:
- ddev (Drush helper functions)
- qutebrowser, copyq, yazi, lazygit, lazydocker (for config link mappings)
- code command on PATH (for VS Code settings/keybindings link mappings)
- nvidia-smi and steam (GPU offload helpers)

### Manual Atuin Setup for a Fresh Clone

If you have just cloned this framework and want to prepare Atuin manually, run:

- ./scripts/setup-atuin.sh --install
- ./scripts/setup-atuin.sh --symlink-only

This script will:
- install Atuin via `mise` when available, or via `cargo` if `mise` is not installed
- create the expected `~/.files/.atuin` and `~/.files/.atuin/data` layout
- symlink `~/.config/atuin` to `~/.files/.atuin`
- symlink `~/.local/share/atuin` to `~/.files/.atuin/data`
- create a minimal `config.toml` if it is missing

After setup, reload the shell:

- source ~/.zshrc

### Nextcloud Workflow

The framework includes a Nextcloud helper module for a simple `rclone`-based workflow.

Typical setup:

1. Configure a `rclone` remote named `nextcloud`:
- rclone config
2. Set the local directory and remote path in the shell if needed:
- export NEXTCLOUD_LOCAL_DIR="$HOME/Nextcloud"
- export NEXTCLOUD_REMOTE_NAME="nextcloud"
- export NEXTCLOUD_REMOTE_PATH="/"
3. Use the helpers:
- nextcloud-sync-up
- nextcloud-sync-down
- nextcloud-sync up
- nextcloud-sync down
- nextcloud-mount
- nextcloud-ls

Examples:

- nextcloud-sync-up
- nextcloud-sync down --dry-run
- nextcloud-mount "$HOME/Nextcloud/mounted"

The helpers use `rclone sync` so they work best when your Nextcloud remote is already configured via `rclone`.

### Daily Workflow

1. Start shell and verify:
- source ~/.zshrc

2. Pick your prompt and theme behavior once:
- export ZSH_THEME=none
- export ZSH_PROMPT_LAYOUT=singleline
- export ZSH_PROMPT_ASYNC_GIT=true

3. Bootstrap project workspace when needed:
- zsh_setup --setup-all

4. Let environment automation work for you:
- Python venv auto-switching on directory change
- Node/NVM lazy loading only when entering Node repos
- Git identity sync on repo entry

5. Use safe, preview-first updates:
- tools --setup-links --dry-run
- tools --setup-links
- tools --update --dry-run
- tools --update

6. Keep plugin repos current and fork-safe:
- zsh_plugins --check-forks --dry-run
- zsh_plugins --install
- zsh_plugins --update --check-forks

7. For Git credentials in pass:
- git-pass-save
- git-env-sync

### Automated Tooling Updates

Policy-aware update wrapper:
- ./scripts/update-tools.sh
- ./scripts/update-tools.sh --dry-run
- ./scripts/update-tools.sh --scheduled --no-plasma --no-vscode
- ./scripts/update-tools.sh --ensure-user-timer

Behavior:
- Always runs `tools --update`.
- Enforces root safety by adding `--no-brew` automatically in root sessions.
- `--scheduled` disables privileged/interactive update stages (`--no-paru --no-grub --no-firmware`).
- `--ensure-user-timer` auto-installs and enables the user systemd timer when user systemd is available.
- Homebrew PHP formula fallback uses a macOS-safe portable version sort strategy.

VS Code tasks:
- `tools:update`
- `tools:update:dry-run`
- `tools:update:scheduled-safe`
- `tools:install-user-timer`
- `tools:update:auto-timer`

Copilot deterministic enforcement hook:
- `.github/hooks/upgrade-policy-guard.json`
- Blocks unsafe upgrade paths such as `sudo brew ...` or `doas brew ...`.

systemd user timer template:
1. `mkdir -p ~/.config/systemd/user`
2. `cp scripts/systemd/zsh-tools-update.service ~/.config/systemd/user/`
3. `cp scripts/systemd/zsh-tools-update.timer ~/.config/systemd/user/`
4. `systemctl --user daemon-reload`
5. `systemctl --user enable --now zsh-tools-update.timer`

Auto-installer alternative:
- `./scripts/systemd/install-user-timer.sh`
- Safely skips when `systemctl` or user systemd manager is unavailable.

cron template:
- Use the line in `scripts/cron/zsh-tools-update.cron` in `crontab -e`.
- Logs default to `~/.cache/zsh-tools-update.log`.

### Copilot Specs and Agents

Workspace policy and scoped instruction specs:
- `.github/copilot-instructions.md`
- `.github/instructions/*.instructions.md`

Custom startup-focused agent:
- `.github/agents/zsh-startup-guardian.agent.md`

Prompt specs for recurring maintenance:
- `.github/prompts/startup-safety-review.prompt.md`
- `.github/prompts/dependency-policy-check.prompt.md`

Deterministic guard hook:
- `.github/hooks/upgrade-policy-guard.json`
- `scripts/hooks/guard-upgrade-paths.sh`

### Performance-Safe Defaults

- Keep ZSH_PROMPT_ASYNC_GIT=true.
- Keep lazy loading for NVM/completions enabled.
- Use tools --dry-run before full system updates.
- Keep plugin set lean in root shells unless intentionally overridden.

## Notes

- Root shell plugin behavior is intentionally reduced unless explicitly overridden.
- Several features are context-aware and only activate inside matching project types.
- Startup cache files are stored under ~/.cache/zsh.
- Docker helper `d-kill-pattern` uses a portable loop implementation (no GNU-only `xargs -r`).

## Credits and Inspiration

### Included/Forked Plugins

The plugin list in this setup may use personal forks for maintenance, but these are the upstream projects that the functionality originates from:

- zsh-abbr: https://github.com/olets/zsh-abbr
- zsh-autocompletion: https://github.com/marlonrichert/zsh-autocomplete
- zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions
- zsh-colors: https://github.com/zpm-zsh/colors
- zsh-completions: https://github.com/zsh-users/zsh-completions
- zsh-doas-zsh-plugin inspiration: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
- zsh-docker-helpers: https://github.com/unixorn/docker-helpers.zshplugin
- zsh-drupal: https://github.com/yhaefliger/zsh-drupal
- zsh-eza: https://github.com/z-shell/zsh-eza
- zsh-F-Sy-H (fast syntax highlighting): https://github.com/zdharma-continuum/fast-syntax-highlighting
- zsh-figures: https://github.com/zpm-zsh/figures
- zsh-fzf-git-branches: https://github.com/awerebea/fzf-git-branches
- zsh-fzf-plugin: https://github.com/unixorn/fzf-zsh-plugin
- zsh-fzf-tab: https://github.com/Aloxaf/fzf-tab
- zsh-magic-dashboard: https://github.com/chrisgrieser/zsh-magic-dashboard
- zsh-mise: https://github.com/wintermi/zsh-mise
- zsh-ssh: https://github.com/sunlei/zsh-ssh
- zsh-you-should-use: https://github.com/MichaelAquilina/zsh-you-should-use

### Runtime and Tooling Ecosystem

- Docker engine and CLI: https://github.com/docker/cli
- Docker Compose v2: https://github.com/docker/compose
- Colima (local container runtime): https://github.com/abiosoft/colima
- Lazydocker: https://github.com/jesseduffield/lazydocker
- fzf: https://github.com/junegunn/fzf
- mise: https://github.com/jdx/mise
- zoxide: https://github.com/ajeetdsouza/zoxide
- atuin: https://github.com/atuinsh/atuin
- direnv: https://github.com/direnv/direnv
- eza: https://github.com/eza-community/eza
- ripgrep: https://github.com/BurntSushi/ripgrep

### Prompt/Theme and UX Inspiration

- typewritten theme family: https://github.com/reobin/typewritten
- Oh My Zsh magic-enter behavior inspiration: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/magic-enter

If any upstream attribution is missing or outdated, update this section to reflect the original project rather than the local fork URL.
