# Agentic Starter Framework

Generalized reusable framework for setting up agentic project workflows.

## What to Keep
1. A fixed `/.agent/` structure with durable docs (`INDEX`, `CONTINUITY`, `CONTEXT`, `helpers/INDEX`, `RUNBOOK`, `PATTERNS`, `DECISIONS`, `PROMPTS`).
2. A continuity-first startup order (`INDEX` -> `CONTINUITY` -> `CONTEXT` -> `WORKFLOW`).
3. A required end-of-task learning loop for substantial work (note -> promote -> continuity update).
4. Separate "scratch" (`notes/`) from "durable policy" (`RUNBOOK`/`PATTERNS`/`DECISIONS`).
5. Plan artifacts with lifecycle (`execplans/active` -> `execplans/archive` + registry update).
6. ExecPlan quality and lifecycle rules in `/.agent/PLANS.md`.
7. Automated hygiene checks via `scripts/agent-hygiene-check.sh` and CI workflow.

## Canonical Loop
1. Bootstrap session from `/.agent/INDEX.md`.
2. Load `/.agent/CONTINUITY.md` for current Goal/Now/Next/Open Questions.
3. Validate constraints in `/.agent/CONTEXT.md`, then execute task.
4. Capture task-specific findings in `/.agent/notes/YYYY-MM-DD_topic.md`.
5. At task end, run a failure review:
- what went wrong?
- why?
- what prevention rule/check should be added?
6. Promote only durable learnings into:
- `helpers/*.md` + `helpers/INDEX.md` for machine-facing repeatable playbooks.
- `RUNBOOK.md` for procedural steps/commands.
- `PATTERNS.md` for coding patterns and anti-patterns.
- `DECISIONS.md` for architecture or policy decisions.
7. Update `CONTINUITY.md` with current state and recent receipts.

## Promotion Gate
Promote an item to durable docs only if one is true:
1. It prevented a bug/regression.
2. It saved time in at least two tasks.
3. It defines a repo-specific constraint.
4. It changes how future work should be done.

## Durable Entry Quality Bar
Each durable rule should include:
1. Scope.
2. Trigger.
3. Concrete procedure/rule.
4. Failure mode if ignored.

## Starter Setup Checklist
1. Copy the `/.agent/` tree into a new repo.
2. Fill project-specific fields marked `UNCONFIRMED` in `CONTEXT.md`, `RUNBOOK.md`, and `AGENTS.md`.
3. Keep `notes/`, `execplans/active/`, and `execplans/archive/` tracked with `.gitkeep`.
4. Add at least one reusable prompt to `PROMPTS.md` for bootstrap and one for end-of-task review.
5. Enforce "facts only" in continuity and include dated provenance tags.
6. Enable CI check in `.github/workflows/agent-hygiene.yml`.
7. Run weekly review with `scripts/agent-weekly-review.sh`.

## Keep vs Customize
Keep unchanged:
1. File layout.
2. Startup order.
3. Promotion rules.
4. Continuity ledger format.

Customize per repo:
1. Architecture and constraints in `CONTEXT.md`.
2. Operational commands in `RUNBOOK.md`.
3. Domain-specific patterns and anti-patterns.
4. Decision log entries and IDs.
