#!/usr/bin/env sh
set -eu

payload="$(cat 2>/dev/null || true)"

extract_with_jq() {
  key_expr="$1"
  if command -v jq >/dev/null 2>&1; then
    printf '%s' "$payload" | jq -r "$key_expr // \"\"" 2>/dev/null || true
  fi
}

extract_with_sed() {
  key_name="$1"
  printf '%s' "$payload" | sed -n "s/.*\"$key_name\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -n1
}

tool_name="$(extract_with_jq '.toolName')"
if [ -z "$tool_name" ]; then
  tool_name="$(extract_with_sed 'toolName')"
fi

command_text="$(extract_with_jq '.toolInput.command')"
if [ -z "$command_text" ]; then
  command_text="$(extract_with_jq '.arguments.command')"
fi
if [ -z "$command_text" ]; then
  command_text="$(extract_with_sed 'command')"
fi

if [ "$tool_name" != "run_in_terminal" ] && [ "$tool_name" != "functions.run_in_terminal" ]; then
  exit 0
fi

is_root=0
if [ "$(id -u)" -eq 0 ]; then
  is_root=1
fi

# Disallow brew execution in root sessions, and explicit sudo/doas brew flows.
if [ "$is_root" -eq 1 ] && printf '%s' "$command_text" | grep -Eq '(^|[[:space:]])brew([[:space:]]|$)'; then
  cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Unsafe upgrade path: brew commands are blocked in root sessions."},"stopReason":"Blocked unsafe upgrade path","systemMessage":"Use mise-first flow or system package manager tooling for root sessions; brew is allowed only for non-root fallback when mise has no match."}
EOF
  exit 2
fi

if printf '%s' "$command_text" | grep -Eq '(^|[[:space:]])(sudo|doas)[[:space:]].*\bbrew\b'; then
  cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Unsafe upgrade path: sudo/doas brew commands are blocked."},"stopReason":"Blocked unsafe upgrade path","systemMessage":"Do not run brew with sudo/doas. Use non-root brew fallback only when mise has no matching package."}
EOF
  exit 2
fi

exit 0
