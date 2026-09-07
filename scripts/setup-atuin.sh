#!/usr/bin/env zsh
set -euo pipefail

repo_root="${0:A:h:h}"
files_root="${FILES:-$HOME/.files}"
atuin_files_dir="${files_root}/.atuin"
atuin_data_dir="${atuin_files_dir}/data"
config_target="${HOME}/.config/atuin"
data_target="${HOME}/.local/share/atuin"
manual_mode=0
symlink_only=0

usage() {
  cat <<'EOF'
setup-atuin.sh [--install] [--symlink-only] [--dry-run]

Install and configure Atuin for a fresh clone of this zsh framework.

Behavior:
  - installs Atuin with mise when available, otherwise with cargo
  - creates ~/.files/.atuin and ~/.files/.atuin/data if needed
  - symlinks ~/.config/atuin -> ~/.files/.atuin
  - symlinks ~/.local/share/atuin -> ~/.files/.atuin/data
  - writes a minimal config.toml when absent

Examples:
  ./scripts/setup-atuin.sh
  ./scripts/setup-atuin.sh --install
  ./scripts/setup-atuin.sh --symlink-only
  ./scripts/setup-atuin.sh --dry-run
EOF
}

for arg in "$@"; do
  case "$arg" in
    --help|-h)
      usage
      exit 0
      ;;
    --install)
      manual_mode=1
      ;;
    --symlink-only)
      symlink_only=1
      ;;
    --dry-run)
      dry_run=1
      ;;
    *)
      echo "setup-atuin: unknown flag '$arg'"
      usage
      exit 1
      ;;
  esac
done

if [[ -n "${dry_run:-0}" ]] && [[ "${dry_run}" != "0" ]]; then
  dry_run=1
else
  dry_run=0
fi

ensure_parent_dir() {
  local target_dir="$1"
  if (( dry_run )); then
    echo "[dry-run] mkdir -p '$target_dir'"
    return 0
  fi
  mkdir -p "$target_dir"
}

link_path() {
  local source_path="$1"
  local target_path="$2"
  local target_dir="${target_path:h}"

  if (( dry_run )); then
    if [[ -L "$target_path" || -e "$target_path" ]]; then
      echo "[dry-run] rm -f '$target_path' && ln -s '$source_path' '$target_path'"
    else
      echo "[dry-run] mkdir -p '$target_dir' && ln -s '$source_path' '$target_path'"
    fi
    return 0
  fi

  ensure_parent_dir "$target_dir"

  if [[ -L "$target_path" ]]; then
    if [[ "$(readlink "$target_path")" == "$source_path" ]]; then
      return 0
    fi
    rm -f "$target_path"
  elif [[ -e "$target_path" ]]; then
    mv "$target_path" "${target_path}.bak.$(date +%s)"
  fi

  ln -s "$source_path" "$target_path"
}

install_atuin() {
  if command -v atuin >/dev/null 2>&1; then
    echo "setup-atuin: atuin already available: $(command -v atuin)"
    return 0
  fi

  if command -v mise >/dev/null 2>&1; then
    echo "setup-atuin: installing atuin via mise"
    if (( dry_run )); then
      echo "[dry-run] mise use --global atuin"
      return 0
    fi
    mise use --global atuin || return 1
    return 0
  fi

  if command -v cargo >/dev/null 2>&1; then
    echo "setup-atuin: installing atuin via cargo"
    if (( dry_run )); then
      echo "[dry-run] cargo install atuin --locked --root '$HOME/.local'"
      return 0
    fi
    cargo install atuin --locked --root "$HOME/.local" || return 1
    export PATH="$HOME/.local/bin:$PATH"
    return 0
  fi

  echo "setup-atuin: atuin is not installed and neither mise nor cargo is available." >&2
  echo "setup-atuin: install it manually, then rerun this script." >&2
  echo "setup-atuin: examples:" >&2
  echo "  mise use --global atuin" >&2
  echo "  cargo install atuin --locked" >&2
  return 1
}

ensure_files_layout() {
  ensure_parent_dir "$atuin_files_dir"
  ensure_parent_dir "$atuin_data_dir"

  if [[ ! -f "$atuin_files_dir/config.toml" ]]; then
    if (( dry_run )); then
      echo "[dry-run] cat > '$atuin_files_dir/config.toml' <<'EOF'"
      echo "[sync]"
      echo "records = true"
      echo "EOF"
    else
      cat > "$atuin_files_dir/config.toml" <<'EOF'
[sync]
records = true
EOF
    fi
  fi
}

ensure_symlinks() {
  if [[ -n "$config_target" ]]; then
    link_path "$atuin_files_dir" "$config_target"
  fi

  if [[ -n "$data_target" ]]; then
    link_path "$atuin_data_dir" "$data_target"
  fi
}

if (( symlink_only )); then
  ensure_files_layout
  ensure_symlinks
  echo "setup-atuin: symlinks ready"
  exit 0
fi

if (( manual_mode )); then
  install_atuin
fi

ensure_files_layout
ensure_symlinks

echo "setup-atuin: ready"

echo "setup-atuin: source ~/.zshrc to load atuin shell init"
printf '%s\n' "setup-atuin: shell init hook: source_cached_init atuin init zsh"
