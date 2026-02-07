# Runbook

## Setup and local run
1. Install dependencies: `UNCONFIRMED`
2. Start local services: `UNCONFIRMED`
3. Run app locally: `UNCONFIRMED`

## Build/test/quality
1. Build: `UNCONFIRMED`
2. Test: `UNCONFIRMED`
3. Lint: `UNCONFIRMED`
4. Typecheck: `UNCONFIRMED`
5. Required pre-finalization checks (fill with concrete commands): `UNCONFIRMED`

## Database operations
1. Migration command: `UNCONFIRMED`
2. Seed command: `UNCONFIRMED`
3. Rollback/recovery: `UNCONFIRMED`

## Incident basics
1. Health check endpoint/command: `UNCONFIRMED`
2. Log query path: `UNCONFIRMED`
3. Rollback command/path: `UNCONFIRMED`

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
