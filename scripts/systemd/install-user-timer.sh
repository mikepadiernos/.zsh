#!/usr/bin/env zsh
set -euo pipefail

typeset -r script_dir="${0:A:h}"
typeset -r repo_root="${script_dir:h:h}"

typeset -r service_src="$repo_root/scripts/systemd/zsh-tools-update.service"
typeset -r timer_src="$repo_root/scripts/systemd/zsh-tools-update.timer"
typeset -r user_systemd_dir="$HOME/.config/systemd/user"

if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemd-user: skipping (systemctl not found)"
  exit 0
fi

if ! systemctl --user show-environment >/dev/null 2>&1; then
  echo "systemd-user: skipping (user systemd manager unavailable)"
  exit 0
fi

if [[ ! -f "$service_src" || ! -f "$timer_src" ]]; then
  echo "systemd-user: missing timer templates under scripts/systemd"
  exit 1
fi

mkdir -p "$user_systemd_dir"
cp "$service_src" "$user_systemd_dir/zsh-tools-update.service"
cp "$timer_src" "$user_systemd_dir/zsh-tools-update.timer"

systemctl --user daemon-reload
systemctl --user enable --now zsh-tools-update.timer >/dev/null

echo "systemd-user: enabled zsh-tools-update.timer"
