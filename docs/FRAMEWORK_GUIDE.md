# Framework Guide

Canonical guide for this starter workflow.

## Goals
1. Keep the template simple and reusable.
2. Keep process guidance explicit and machine-checkable.
3. Capture only high-leverage improvements into durable rules.

## Modes
1. `template` mode
- Intended for maintaining this template repository.
- Keep scaffold files present but sanitized.
- Do not add live task-state entries to `CONTINUITY`, `DECISIONS`, `notes/`, `helpers/`, or `execplans/`.

2. `project` mode
- Intended for downstream cloned repositories.
- Use full self-improving workflow with live capture and promotion.

## Core Loop (Substantial Tasks)
1. Clarify
2. Plan
3. Implement
4. Validate
5. Capture

Capture uses a balanced review:
1. What went wrong, why, and what prevention rule?
2. What went right, what measurably improved (time/readability/performance/manageability/modularity), and is it reusable?
3. For each item choose: `promote now | pilot backlog | keep local`.

## Promotion Gate (80/20)
Promote to durable docs only when the item is high-leverage and reusable.

Promote now examples:
1. Prevents recurring failures.
2. Saves meaningful time across tasks.
3. Improves maintainability/readability in repeatable patterns.
4. Changes how future work should be done.

Otherwise:
1. `pilot backlog` in notes (project mode).
2. `keep local` for one-off context.

## Source of Authority
1. `AGENTS.md`: concise policy entrypoint.
2. `/.agent/WORKFLOW.md`: full execution + capture behavior.
3. `README.md`: onboarding and mode usage.

## Instruction Strategy
1. Prefer `AGENTS.md` as the primary instruction layer for repo behavior.
2. Use skills as optional accelerators for specialized/repetitive workflows, not as the default policy container.
3. Keep root `AGENTS.md` concise and durable; place long operational detail in `/.agent/*` docs or scripts.
4. Enforce a root `AGENTS.md` size budget (`12288` bytes max) through hygiene checks.

## Harness-agnostic policy boundary
1. Core workflow/policies stay in `AGENTS.md` and `/.agent/*`.
2. Harness-specific behavior belongs in adapter docs/scripts, not core policy text.

## References
1. `codex-starter` (attribution for portable behavior patterns): https://github.com/Skarian/codex-starter
2. Vercel eval note on instruction strategy: https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals

## Script Usage
```bash
# template repository maintenance
make hygiene MODE=template
make review MODE=template

# downstream project repository
make init-project
make hygiene MODE=project
make review MODE=project
```

Hygiene thresholds (for example continuity size caps and AGENTS.md size cap) are configurable in `/.agent/settings.toml` under `[hygiene]`.

## Weekly Review Intent
1. Enforce mode-specific hygiene.
2. Surface stale or unexpected state artifacts.
3. Surface contradiction/duplication candidates for pruning.
4. Keep `UNCONFIRMED` placeholders moving toward concrete commands.
