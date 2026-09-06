#!/usr/bin/env zsh
set -euo pipefail

script_dir="${0:A:h}"
repo_root="${script_dir:h}"

cd "$repo_root"

typeset -a passthrough_flags=( )
typeset -a tool_args=( --update )
typeset -i scheduled_mode=0
typeset -i ensure_user_timer=0

for arg in "$@"; do
  case "$arg" in
    --scheduled)
      scheduled_mode=1
      ;;
    --ensure-user-timer)
      ensure_user_timer=1
      ;;
    --help|-h)
      cat <<'EOF'
update-tools.sh [--scheduled] [--ensure-user-timer] [tools --update flags...]

Examples:
  ./scripts/update-tools.sh
  ./scripts/update-tools.sh --dry-run
  ./scripts/update-tools.sh --scheduled
  ./scripts/update-tools.sh --ensure-user-timer
  ./scripts/update-tools.sh --no-flatpak --no-vscode

Behavior:
  - Always runs tools --update
  - Enforces brew safety: adds --no-brew automatically for root user
  - --scheduled mode disables interactive/privileged update stages:
      --no-paru --no-grub --no-firmware
    - --ensure-user-timer installs/enables the user systemd timer when available
EOF
      exit 0
      ;;
    *)
      passthrough_flags+=( "$arg" )
      ;;
  esac
done

if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
  tool_args+=( --no-brew )
fi

if (( scheduled_mode )); then
  tool_args+=( --no-paru --no-grub --no-firmware )
fi

if (( ensure_user_timer )); then
  "$repo_root/scripts/systemd/install-user-timer.sh" || true
fi

tool_args+=( "${passthrough_flags[@]}" )

export ZSH="${ZSH:-$repo_root}"
export ZSH_CONFIGS="${ZSH_CONFIGS:-$repo_root/configs}"
export FILES="${FILES:-$HOME/.files}"

if [[ -f "$ZSH_CONFIGS/.zsh_tools" ]]; then
  source "$ZSH_CONFIGS/.zsh_tools"
else
  echo "update-tools: missing tools config at $ZSH_CONFIGS/.zsh_tools"
  exit 1
fi

if ! whence -w tools >/dev/null 2>&1; then
  echo "update-tools: tools function is unavailable; ensure ~/.zshrc provides configs/.zsh_tools"
  exit 1
fi

echo "update-tools: running tools ${tool_args[*]}"
tools "${tool_args[@]}"
