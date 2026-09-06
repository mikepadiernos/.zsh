---
mode: "agent"
description: "Enforce dependency auto-install policy: mise first, brew fallback only when allowed."
---

Audit and enforce dependency install policy in startup/plugin flows.

Policy:
- Auto-install remains opt-in.
- Prefer mise first.
- Use brew only when mise has no matching package and only for non-root users.
- Never use brew fallback for root shells.

Tasks:
1. Locate installer and call sites.
2. Identify violations or regressions.
3. Apply minimal fixes.
4. Run targeted syntax checks and a startup smoke check.
5. Report exact files touched and rationale.
