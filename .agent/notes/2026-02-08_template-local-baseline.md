# Task Note: 2026-02-08 template-local-baseline

## Task
- Request: proceed locally on `main`.
- Scope: continue implementation by localizing this starter template with concrete repo defaults and validating hygiene checks.
- Constraints: keep starter contract stable, avoid destructive actions, and capture substantial-task learnings.

## Actions Taken
1. Created and registered `EP-2026-02-08__template-local-baseline`.
2. Replaced placeholder command/context fields in `AGENTS.md`, `/.agent/CONTEXT.md`, and `/.agent/RUNBOOK.md`.
3. Added helper `H-2026-02-08__sandbox-write-failure-recovery` and updated helper index.
4. Ran hygiene validation scripts and captured outcomes.

## What Went Wrong
1. Issue: `git checkout main` failed due sandbox denial creating `.git/index.lock`.
- Root cause: checkout writes git index state; sandbox denied that write path.
- Early signal missed: branch-change was unnecessary because repository was already on `main`.
- Prevention rule: prefer read-only branch verification before write-requiring git commands in sandbox; escalate only when write is essential.

## Reusable Learnings
1. Learning: template repos should replace `UNCONFIRMED` placeholders with explicit `N/A` or concrete commands once scope is known.
- Promote to: `DECISIONS.md`
- Why: prevents ambiguity and speeds handoff.
2. Learning: sandbox write-failure recovery should be codified as helper playbook.
- Promote to: `keep in note`
- Why: helper-first until repeated successful reuse confirms durable promotion.

## Receipts
- Commands run: `rg -n "UNCONFIRMED" ...`, `bash scripts/agent-hygiene-check.sh`, `bash scripts/agent-weekly-review.sh`.
- Files changed: `AGENTS.md`, `/.agent/CONTEXT.md`, `/.agent/RUNBOOK.md`, `/.agent/DECISIONS.md`, `/.agent/helpers/INDEX.md`, `/.agent/helpers/H-2026-02-08__sandbox-write-failure-recovery.md`, `/.agent/execplans/*`.
- Tests/checks: hygiene check passed; weekly review passed with expected informational `UNCONFIRMED` references in templates/guidance text.
