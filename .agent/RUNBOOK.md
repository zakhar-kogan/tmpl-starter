# Runbook

## Setup and local run
1. Install dependencies: none beyond `bash`, `git`, and `rg` for baseline checks.
2. Start local services: `N/A` (no services in this template repository).
3. Run app locally: `N/A` (template docs/scripts only).

## Build/test/quality
1. Build: `N/A` (no build artifact).
2. Test: `bash scripts/agent-hygiene-check.sh`.
3. Lint: `bash scripts/agent-hygiene-check.sh` (includes structural contract checks).
4. Typecheck: `N/A` (no typed application source).
5. Required pre-finalization checks (fill with concrete commands): `bash scripts/agent-hygiene-check.sh` and `bash scripts/agent-weekly-review.sh` (for maintenance sweeps).

## Database operations
1. Migration command: `N/A` (no database in this template).
2. Seed command: `N/A` (no database in this template).
3. Rollback/recovery: `git revert <commit>` for committed changes or `git restore <path>` for uncommitted file rollback.

## Incident basics
1. Health check endpoint/command: `bash scripts/agent-hygiene-check.sh`.
2. Log query path: GitHub Actions run logs for `.github/workflows/agent-hygiene.yml`.
3. Rollback command/path: `git revert <commit>` and update `.agent/CONTINUITY.md` receipts with rollback context.

## Agentic framework maintenance
1. For substantial tasks, create a dated note in `/.agent/notes/` using `/.agent/notes/TEMPLATE.md`.
2. Before finalizing, run a failure review (`what went wrong`, `why`, `prevention rule`).
3. Promote durable rules into `RUNBOOK.md`, `PATTERNS.md`, or `DECISIONS.md`; avoid duplicating note-level detail.
4. Update `/.agent/CONTINUITY.md` with Goal/Now/Next and dated provenance-tagged receipts.
5. Weekly hygiene: prune stale notes, deduplicate conflicting guidance, and update `UNCONFIRMED` commands when known.
6. Run contract checks: `bash scripts/agent-hygiene-check.sh`.
7. Run weekly maintenance review: `bash scripts/agent-weekly-review.sh`.
8. Keep reusable troubleshooting/workflow helpers in `/.agent/helpers/` and index them in `/.agent/helpers/INDEX.md`.
9. Promote stabilized helper patterns into durable docs after repeated successful use.
