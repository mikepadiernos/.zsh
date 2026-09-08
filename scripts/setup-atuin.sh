#!/usr/bin/env zsh
set -euo pipefail

repo_root="${0:A:h:h}"
export ZSH_ATUIN_REPO_ROOT="$repo_root"
source "$repo_root/modules/.zsh_atuin"
zsh_atuin_setup_main "$@"
