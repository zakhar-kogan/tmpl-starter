# Agent Workflow

Use this for substantial tasks. Keep phases ordered.

## Phase 1: Clarify
1. Restate request, scope, and constraints.
2. Mark unknowns as `UNCONFIRMED` instead of guessing.
3. Check `/.agent/helpers/INDEX.md` for relevant helper patterns.

Exit criteria:
1. Task objective is explicit.
2. Assumptions are listed.

## Phase 2: Plan
1. Create a short execution plan in `/.agent/execplans/active/` for major work.
2. Structure major plans according to `/.agent/PLANS.md`.
3. Define validation steps and rollback-safe sequencing.

Exit criteria:
1. Plan steps are concrete and testable.
2. Risks and mitigations are documented.

## Phase 3: Implement
1. Apply small, reviewable diffs.
2. Keep contracts stable unless explicitly changing them.
3. Record important commands/files in task notes.

Exit criteria:
1. Changes are complete for scoped objective.
2. Diff size stays reviewable.

## Phase 4: Validate
1. Run relevant checks (build/test/lint/typecheck) if commands are known.
2. If a command is `UNCONFIRMED` or unavailable, report the gap explicitly.

Exit criteria:
1. Validation evidence is captured.
2. Remaining risk is stated.

## Phase 5: Capture
1. Add a short note in `/.agent/notes/` (substantial tasks).
2. Promote durable rules into `RUNBOOK`, `PATTERNS`, or `DECISIONS`.
3. Update `CONTINUITY` with Goal/Now/Next plus receipts.
4. Update existing helper docs in `/.agent/helpers/` or create a new one from `/.agent/helpers/TEMPLATE.md`.

Exit criteria:
1. Reusable learning is persisted.
2. Continuity state is current.
3. Helper memory is updated for repeated or costly failures.
