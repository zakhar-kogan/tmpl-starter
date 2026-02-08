# Helper: H-2026-02-08__sandbox-write-failure-recovery

## Metadata
- Status: `ACTIVE`
- Scope: local agent runs in sandboxed workspace environments.
- Created: `2026-02-08`
- Updated: `2026-02-08`

## Trigger Signals
1. A command fails with `Operation not permitted` while creating lock/state files (for example `.git/index.lock`).
2. The failed command is not essential for task outcome (for example redundant branch checkout).

## Failure Pattern
- Symptom: command fails despite valid syntax and path.
- Root cause: sandbox denies write operation required by the command.
- Early signal missed: command intent required a write path, but a read-only equivalent would have worked.

## Playbook
1. Classify command intent as read-only or write-required.
2. Replace with read-only verification commands when possible (for example `git branch --show-current`, `git status --short`).
3. If write is required and essential, rerun with escalation request and clear justification.
4. Record the failure and recovery path in task receipts.

## Guardrails
1. Do not request escalation for non-essential writes.
2. Avoid destructive recovery commands unless explicitly requested by the user.

## Verification
1. Command/check: rerun task flow with read-only alternatives first.
- Expected result: no sandbox permission failure for non-essential branch/state checks.

## Promotion Notes
- Promote to `RUNBOOK.md` or `PATTERNS.md` after repeated successful use.

## Revision Log
- `2026-02-08`: initial helper created after sandbox write failure on git index lock.
