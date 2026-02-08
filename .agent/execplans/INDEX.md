# ExecPlan Index

Tracks execution plans for this repository.

## Conventions
1. Active plans: `/.agent/execplans/active/`
2. Archived plans: `/.agent/execplans/archive/`
3. Filename format: `EP-YYYY-MM-DD__slug.md`

## Entry format
- `EP-YYYY-MM-DD__slug` — `Status:<DRAFT|ACTIVE|BLOCKED|DONE|ARCHIVED>` — `Created:YYYY-MM-DD` — `Updated:YYYY-MM-DD` — `Path:<repo-relative path>` — `Owner:<UNCONFIRMED|name>` — `Summary:<one line>` — `Links:<optional>`

For archived plans add:
- `Archived:YYYY-MM-DD` — `Outcome:<one line>`

## Template
- Use `/.agent/execplans/active/EP-TEMPLATE.md` when starting a new plan.

## Active ExecPlans
- (none yet)

## Archived ExecPlans
- `EP-2026-02-08__template-local-baseline` — `Status:ARCHIVED` — `Created:2026-02-08` — `Updated:2026-02-08` — `Archived:2026-02-08` — `Path:/.agent/execplans/archive/EP-2026-02-08__template-local-baseline.md` — `Owner:codex` — `Summary:localized template defaults and completed hygiene validation` — `Outcome:core placeholders replaced with concrete local values and helper memory updated`
