# Helper: H-2026-02-07__postmortem-to-helper-update

## Metadata
- Status: `ACTIVE`
- Scope: substantial tasks across this repository.
- Created: `2026-02-07`
- Updated: `2026-02-07`

## Trigger Signals
1. A task had a failure, avoidable rework, or repeated friction.
2. End-of-task review includes concrete causes and prevention rules.

## Failure Pattern
- Symptom: same mistakes recur across tasks despite prior notes.
- Root cause: insights remain in chat or one-off task notes and are not indexed for reuse.
- Early signal missed: no helper update happened during capture phase.

## Playbook
1. Ask: "What went wrong? Why? How do we prevent it next time?"
2. Convert each prevention rule into one of:
- helper update (`/.agent/helpers/*.md`) when it is operational and repeatable.
- durable policy (`RUNBOOK.md` or `PATTERNS.md`) when it is broadly stable.
3. Update `/.agent/helpers/INDEX.md` entry status and summary.
4. Add a receipt in `CONTINUITY.md` noting helper changes.

## Guardrails
1. Keep helper docs compact and machine-facing.
2. Avoid project-secrets or machine-local sensitive data in helpers.

## Verification
1. Command/check: `bash scripts/agent-hygiene-check.sh`
- Expected result: `Agent hygiene checks passed.`

2. Command/check: verify helper is registered in `/.agent/helpers/INDEX.md`.
- Expected result: helper ID appears under `Active Helpers` or `Stable Helpers`.

## Promotion Notes
- Promote to `RUNBOOK.md` or `PATTERNS.md` after repeated successful use.

## Revision Log
- `2026-02-07`: initial helper created from recurring "postmortem-to-improvement" workflow.
