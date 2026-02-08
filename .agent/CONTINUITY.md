# Continuity Ledger

Facts only. No transcripts. If unknown, write `UNCONFIRMED`.
Each entry must include date and provenance tag: `[USER]`, `[CODE]`, `[TOOL]`, `[ASSUMPTION]`.
Update this file whenever Goal/Now/Next/Decisions materially change.

## Size caps
- Snapshot: <= 25 non-empty lines.
- Done (recent): <= 7 bullets.
- Working set: <= 12 bullets.
- Receipts: <= 20 bullets (keep recent, compress older items).

## Snapshot

Goal: keep this repository as a clean, executable agentic-starter baseline with concrete local defaults and enforceable hygiene checks.
Now: starter placeholders in core operator files were localized for this template repo; hygiene validation is green.
Next: archive completed exec plan and continue incremental starter hardening only when new gaps are found.
Open Questions: should sandbox-recovery helper be promoted into durable runbook/pattern guidance after additional successful uses?

## Done (recent)
- `2026-02-08` `[CODE]` localized project-specific defaults in `AGENTS.md`, `/.agent/CONTEXT.md`, and `/.agent/RUNBOOK.md`.
- `2026-02-08` `[CODE]` added helper `H-2026-02-08__sandbox-write-failure-recovery` and indexed it under active helpers.
- `2026-02-08` `[TOOL]` validated repo contract via hygiene and weekly review scripts.

## Working set
- `2026-02-08` `[CODE]` no active exec plans; continue maintenance via incremental substantial-task plans.

## Decisions
- `2026-02-08` `[CODE]` `D-006` in `/.agent/DECISIONS.md` (template defaults should be explicit, not placeholder `UNCONFIRMED`).

## Receipts
- `2026-02-08` `[TOOL]` `bash scripts/agent-hygiene-check.sh` -> passed.
- `2026-02-08` `[TOOL]` `bash scripts/agent-weekly-review.sh` -> passed.
- `2026-02-08` `[TOOL]` `rg -n "UNCONFIRMED" AGENTS.md .agent .github docs scripts` used to identify unresolved placeholders.
- `2026-02-08` `[TOOL]` sandbox-denied write observed for `git checkout main` (`.git/index.lock`), handled by read-only fallback.
- `2026-02-08` `[TOOL]` archived plan via `mv .agent/execplans/active/EP-2026-02-08__template-local-baseline.md .agent/execplans/archive/EP-2026-02-08__template-local-baseline.md` and updated `/.agent/execplans/INDEX.md`.
