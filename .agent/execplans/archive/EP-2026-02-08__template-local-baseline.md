# ExecPlan: EP-2026-02-08__template-local-baseline

## Metadata
- Status: `ARCHIVED`
- Created: `2026-02-08`
- Last Updated: `2026-02-08`
- Owner: `codex`

## Purpose / Big Picture
Replace placeholder `UNCONFIRMED` values with concrete, repo-accurate defaults so this template can be used locally without ambiguity.

## Scope and Constraints
- In scope:
  - Update `AGENTS.md`, `/.agent/CONTEXT.md`, and `/.agent/RUNBOOK.md` with template-specific defaults.
  - Update continuity and task-capture artifacts for this substantial task.
  - Run local hygiene validation.
- Out of scope:
  - Application feature implementation (this repo is a process template, not an app).
  - Adding new external dependencies or host-level tools.
- Constraints:
  - Keep starter contract structure stable.
  - Keep diffs small and reviewable.
  - Record clear validation evidence.

## Progress
- [x] Clarify task goal and constraints.
- [x] Plan update targets and validation.
- [x] Apply file updates.
- [x] Run hygiene checks.
- [x] Capture note/helper/continuity updates.

## Decision Log
- `2026-02-08`: Treat this task as starter-localization work on `main` because prior referenced commit history does not exist in this repository.
- `2026-02-08`: Updated starter defaults in `AGENTS.md`, `/.agent/CONTEXT.md`, and `/.agent/RUNBOOK.md`.
- `2026-02-08`: Added helper `H-2026-02-08__sandbox-write-failure-recovery` and registered it in `/.agent/helpers/INDEX.md`.
- `2026-02-08`: Validation passed via `bash scripts/agent-hygiene-check.sh` and `bash scripts/agent-weekly-review.sh`.

## Plan of Work
1. Update project command fields in `AGENTS.md`.
2. Replace context placeholders in `/.agent/CONTEXT.md`.
3. Replace runbook placeholders in `/.agent/RUNBOOK.md`.
4. Add and register a helper for sandbox write-failure recovery if needed.
5. Run `bash scripts/agent-hygiene-check.sh`.
6. Record task note and update continuity.

## Validation and Acceptance
- Command: `bash scripts/agent-hygiene-check.sh`
- Expected: exits 0 with `Agent hygiene checks passed.`

## Idempotence and Recovery
- All changes are documentation/script metadata updates and are safe to re-run/edit.
- Recovery is `git restore --staged/working` of touched files if rollback is needed.

## Outcomes and Retrospective
- Outcome: placeholder-heavy baseline is localized with concrete template defaults and passing hygiene checks.
- Retrospective: sandbox write limitations on git lockfile creation are a recurring friction point; helper coverage was added for this recovery pattern.
