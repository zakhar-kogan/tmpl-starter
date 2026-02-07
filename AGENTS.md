# AGENTS

## Session startup
1. Read `/.agent/INDEX.md`.
2. Read `/.agent/CONTINUITY.md` before executing.
3. Review `/.agent/CONTEXT.md` for current architecture and constraints.
4. Follow `/.agent/WORKFLOW.md` for phase gates on substantial tasks.
5. Read `/.agent/helpers/INDEX.md` for reusable failure-handling helpers.

## Working rules
1. Explore first, then implement with small, reviewable diffs.
2. Prefer reversible changes and explicit assumptions.
3. Keep machine-readable contracts stable (APIs, schemas, migrations).
4. Run relevant tests/checks before finalizing and report gaps explicitly.
5. For substantial tasks, complete phases in order: clarify -> plan -> implement -> validate -> capture.
6. Keep `AGENTS.md` process-focused; app/runtime prompting belongs in app-specific prompt files.
7. If a subdirectory adds local constraints, add a local `AGENTS.md` there and keep it consistent with root policy.
8. For common/commodity functionality, evaluate existing libraries before building from scratch.
9. Do not install host-level packages unless explicitly requested by the user.

## Self-improvement loop (required on substantial tasks)
1. At task end, answer: "What went wrong? Why? How do we prevent it next time?"
2. Add a short task note to `/.agent/notes/`.
3. Promote durable learnings into:
- `/.agent/RUNBOOK.md` for operational procedures.
- `/.agent/PATTERNS.md` for coding patterns and anti-patterns.
- `/.agent/DECISIONS.md` for architecture decisions.
4. Update or add relevant helper docs under `/.agent/helpers/` and register them in `/.agent/helpers/INDEX.md`.
5. Update `/.agent/CONTINUITY.md` whenever Goal/Now/Next/Decisions materially change.

## Adaptive helper memory
1. Use `/.agent/helpers/` for machine-facing reusable troubleshooting and workflow helpers.
2. Every helper must be listed in `/.agent/helpers/INDEX.md`.
3. After each substantive failure review, either:
- update an existing helper, or
- add a new helper from `/.agent/helpers/TEMPLATE.md`.
4. When a helper pattern stabilizes after repeated successful use, promote durable parts into `RUNBOOK.md` or `PATTERNS.md`.

## Planning artifacts
1. Store major plans in `/.agent/execplans/active/`.
2. Register every plan in `/.agent/execplans/INDEX.md`.
3. Archive completed plans into `/.agent/execplans/archive/` and update index.
4. For major features/refactors, follow `/.agent/PLANS.md`.

## Maintenance cadence
1. After substantial tasks: update continuity and promote durable learnings.
2. Weekly: prune stale notes, remove contradictions, and keep command/check docs current.

## Research and sourcing
1. When uncertain or working with version-sensitive behavior, verify against primary sources.
2. Record key source-driven decisions in `/.agent/CONTINUITY.md` receipts.

## Project-specific configuration (fill this per repo)
1. Build command: `UNCONFIRMED`
2. Test command: `UNCONFIRMED`
3. Lint command: `UNCONFIRMED`
4. Typecheck command: `UNCONFIRMED`
5. Dev run command: `UNCONFIRMED`
6. Agent hygiene check: `bash scripts/agent-hygiene-check.sh`
7. Weekly maintenance review: `bash scripts/agent-weekly-review.sh`
