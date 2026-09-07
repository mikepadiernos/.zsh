# shellcheck shell=bash disable=SC1090,SC1091
# Zsh configuration

# zmodload zsh/zprof

# Core environment
export LC_ALL=en_US.UTF-8
export SHELL="$(command -v zsh 2>/dev/null || print -r -- "${SHELL:-/bin/zsh}")"
export EDITOR=nvim
export DIRENV_SKIP_TIMEOUT=TRUE

case "${EUID:-$(id -u 2>/dev/null)}:${ZSH_STARTUP_QUIET:-false}" in
	0:*|*:1|*:true|*:yes|*:on)
		export MISE_DISABLE_TOOLS="${MISE_DISABLE_TOOLS:-git,atuin}"
		;;
esac

# Optional portability overrides (uncomment and edit per machine/user)
# export ZSH_RUNTIME_USER="your-username"
# export ZSH_SUDO_PASS_ENTRY="local/sudo/your-username"
# export ZSH_TOOLS_SUDO_PASS_ENTRY="pass.local.sudo.your-username"
# export ZSH_TOOLS_SUDO_PASS_ENTRY_ALT="local/sudo/your-username"
# export ZSH_PLUGINS_FORK_OWNERS="your-forks,team-forks"
# export ZSH_PLUGINS_FORK_OWNER_REGEX='(fork|forks)$'
# export ZSH_PLUGINS_FORK_URL_REGEX='github.com[:/](your-user|your-org-forks)/'
# export ZSH_GIT_DEFAULT_NAME="Your Name"
# export ZSH_GIT_DEFAULT_EMAIL="you@example.com"
# export ZSH_GIT_PERSONAL_NAME="Your Personal Name"
# export ZSH_GIT_PERSONAL_EMAIL="you@personal.example"
# export ZSH_GIT_WORK_NAME="Your Work Name"
# export ZSH_GIT_WORK_EMAIL="you@work.example"

# App Config paths
export FILES="${FILES:-$HOME/.files}"

# Prompt preference
export ZSH_PROMPT_LAYOUT="singleline_verbose"

# Project paths
export ZSH="$HOME/.zsh"
export ZSH_CONFIGS="$ZSH/configs"
export ZSH_MODULES="$ZSH/modules"
export ZSH_PLUGINS="$ZSH/plugins"
export ZSH_THEMES="$ZSH/themes"

# Tool paths
export CARGO="$HOME/.cargo/bin"
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export PASSWORD_STORE_DIR="$HOME/.pass"
export GPG_PASSPHRASE_PASS_ENTRY="gpg/passphrase"

# PATH setup
typeset -U path PATH
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.local/share/pnpm" ]] && path=("$HOME/.local/share/pnpm" $path)
[[ -d "$CARGO" ]] && path=($path "$CARGO")
[[ -d "$GOBIN" ]] && path=($path "$GOBIN")
[[ -d "$GOPATH/bin" ]] && path=($path "$GOPATH/bin")

# Shell bootstrap
source "${ZSH_CONFIGS}/.zsh_bootstrap"

# zprof
