# Decisions

Use ADR-lite entries:
- ID: `D-###`
- Status: `ACTIVE | SUPERSEDED`
- Date: `YYYY-MM-DD`
- Decision:
- Why:
- Impact:

## Decision Log

### D-001 (Agentic starter uses fixed .agent contract)
- Status: ACTIVE
- Date: 2026-02-07
- Decision: Keep a fixed `/.agent` layout with continuity-first startup and required end-of-task promotion loop for substantial work.
- Why: A stable contract makes cross-session execution consistent and allows reusable automation across repositories.
- Impact: New repos should fill project-specific values without changing the layout or workflow semantics.

### D-002 (Starter includes executable templates)
- Status: ACTIVE
- Date: 2026-02-07
- Decision: Include starter templates for notes and execplans (`/.agent/notes/TEMPLATE.md`, `/.agent/execplans/active/EP-TEMPLATE.md`).
- Why: Empty directories are easy to ignore; concrete templates improve adoption and consistency.
- Impact: Contributors should instantiate templates instead of inventing ad hoc formats.

### D-003 (ExecPlan policy is explicit)
- Status: ACTIVE
- Date: 2026-02-07
- Decision: Add a dedicated `/.agent/PLANS.md` to define when plans are required and how they are structured.
- Why: Complex tasks need a consistent planning contract across sessions.
- Impact: Major features/refactors should create and maintain plans under `/.agent/execplans/`.

### D-004 (Agentic maintenance is automated)
- Status: ACTIVE
- Date: 2026-02-07
- Decision: Add scripted and CI-enforced hygiene checks for core `.agent` contract quality.
- Why: Manual review alone is inconsistent and misses drift.
- Impact: `scripts/agent-hygiene-check.sh` and `/.github/workflows/agent-hygiene.yml` should stay green.

### D-005 (Indexed helper memory is part of the contract)
- Status: ACTIVE
- Date: 2026-02-07
- Decision: Maintain machine-facing reusable helpers under `/.agent/helpers/` with index `/.agent/helpers/INDEX.md`.
- Why: Repeated failures should improve future performance without relying on human memory or chat history.
- Impact: Session startup should include helper index review; substantial tasks should update helpers after failure review; stable helper rules should be promoted into durable docs.
