---
description: "Use when editing theme files and theme loader logic. Preserve compatibility with prompt color hooks and fallback behavior."
applyTo: "themes/**"
---

## Theme compatibility
- Keep theme files compatible with zsh prompt color variables consumed by configs/.zsh_prompt.
- Preserve safe fallback behavior when a theme is missing or disabled.
- Avoid adding noisy errors during startup theme loading.

## UX expectations
- Maintain readable contrast and sane defaults for terminal environments.
- Do not break non-unicode fallback behavior.
