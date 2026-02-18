# AGENTS

## Session startup
1. Read `/.agent/INDEX.md`.
2. Read `/.agent/CONTINUITY.md` before executing.
3. Review `/.agent/CONTEXT.md` for current architecture and constraints.
4. Follow `/.agent/WORKFLOW.md` for phase gates on substantial tasks.
5. Read `/.agent/helpers/INDEX.md` for reusable failure-handling helpers.

## Modes
1. `project` mode (default): run the full self-improving loop with live task-state capture.
2. `template` mode: keep the repo sanitized as a reusable scaffold. Do not record live task state in `CONTINUITY`, `DECISIONS`, `notes/`, `helpers/`, or `execplans/`.
3. To enforce strict scaffold hygiene while editing the template itself, set `agent.mode = "template"` in `/.agent/settings.toml`.
4. Use mode-aware scripts:
- Hygiene: `bash scripts/agent-hygiene-check.sh --mode template|project`
- Weekly review: `bash scripts/agent-weekly-review.sh --mode template|project`

## Core rules
1. Explore first, then implement with small, reviewable diffs.
2. Prefer reversible changes and explicit assumptions.
3. Keep machine-readable contracts stable (APIs, schemas, migrations).
4. Run relevant tests/checks before finalizing and report gaps explicitly.
5. For substantial tasks, complete phases in order: clarify -> plan -> implement -> validate -> capture.
6. Keep `AGENTS.md` process-focused; app/runtime prompting belongs in app-specific prompt files.
7. If a subdirectory adds local constraints, add a local `AGENTS.md` there and keep it consistent with root policy.
8. For common/commodity functionality, evaluate existing libraries before building from scratch.
9. Do not install host-level packages unless explicitly requested by the user.
10. Use subagents for bounded parallelizable work (especially exploration/research) to keep the main context focused; synthesize results back into the primary task thread.
11. Default to an autonomous bug-fixing posture: implement and validate directly; ask the user only when scope is ambiguous, constraints conflict, or risk is irreversible.
12. Apply an elegance gate before finalizing: prefer the simplest maintainable solution that a staff-level engineer would approve for clarity, testability, and long-term operability.

## Instruction layering (`AGENTS.md` first, skills second)
1. Treat `AGENTS.md` as the default control plane for repo policy and execution behavior.
2. Use skills only as optional accelerators for specialized, reusable workflows (for example: PDF manipulation, external-service install routines, domain-specific automation).
3. If instructions conflict, prefer repo-local `AGENTS.md` and local subdirectory `AGENTS.md` over generic skill guidance.
4. Keep root `AGENTS.md` concise and durable; move long procedural detail into linked docs/scripts.

## Context budget
1. Keep root `AGENTS.md` within `12288` bytes so instruction discovery remains efficient.
2. When adding new guidance, prefer short policy statements plus references to `/.agent/*` docs instead of embedding long playbooks.
3. If policy text grows beyond budget, split by concern into local `AGENTS.md` files and adapter docs.

## Discussion protocol (numbered findings -> agreement -> execution)
1. When presenting findings (risks, assumptions, tradeoffs, questions, proposed changes), use a numbered list.
2. Keep numbering stable across follow-ups so decisions map 1:1 to items.
3. For substantial tasks, do not begin execution until numbered items are resolved.
4. Read-only exploration is allowed before agreement.

## Dependencies and commodity functionality
1. For common/commodity functionality, evaluate existing libraries before building from scratch.
2. If dependency choice is non-trivial, present options with:
- maintenance health
- license fit
- security posture
- compatibility
- integration cost
3. If no suitable dependency exists, state why and proceed with custom implementation.

## Definition of done
1. Requested change is implemented within agreed scope.
2. Impact is reported (what changed, where, why).
3. Relevant validation is run, or explicit validation gaps are reported.
4. Documentation/config/examples affected by the change are updated.
5. Follow-ups are listed if anything is intentionally deferred.

## External verification (if available)
1. When behavior is uncertain or version-sensitive, verify against primary sources.
2. If external verification is unavailable, mark unknowns as `UNCONFIRMED`.

## End-of-task capture (substantial tasks)
1. Answer both:
- What went wrong, why, and what prevention rule should be added?
- What went right, what measurably improved (time/readability/performance/manageability/modularity), and is it reusable?
2. Triage each item with one decision:
- `promote now` (high-leverage and reusable)
- `pilot backlog` (promising but not proven)
- `keep local` (one-off)
3. Apply captured updates according to active mode in `/.agent/WORKFLOW.md`.

## Planning artifacts (project mode)
1. Store major plans in `/.agent/execplans/active/`.
2. Register every plan in `/.agent/execplans/INDEX.md`.
3. Archive completed plans into `/.agent/execplans/archive/` and update index.
4. For major features/refactors, follow `/.agent/PLANS.md`.

## Research and sourcing
1. When uncertain or working with version-sensitive behavior, verify against primary sources.
2. In `project` mode, record key source-driven decisions in `/.agent/CONTINUITY.md` receipts.

## Project-specific configuration (fill this per repo)
1. Build command: `UNCONFIRMED`
2. Test command: `UNCONFIRMED`
3. Lint command: `UNCONFIRMED`
4. Typecheck command: `UNCONFIRMED`
5. Dev run command: `UNCONFIRMED`
6. Agent hygiene check: `make hygiene MODE=template|project`
7. Weekly maintenance review: `make review MODE=template|project`
