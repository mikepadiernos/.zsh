---
description: "Use when editing modules/. Keep runtime guards strict for non-root shells and avoid hard failures when optional CLIs are unavailable."
applyTo: "modules/**"
---

## Module reliability
- Treat external CLIs as optional unless required by the module contract.
- Guard command usage with availability checks.
- Never run privileged or interactive package-manager actions during startup.

## Docker and toolchain policy
- Preserve docker/colima helper behavior with graceful fallback paths.
- Keep wrapper commands predictable and non-blocking at shell startup.

## Homebrew policy
- Do not invoke brew unless it exists.
- Avoid brew fallback logic for root-oriented startup flows.
