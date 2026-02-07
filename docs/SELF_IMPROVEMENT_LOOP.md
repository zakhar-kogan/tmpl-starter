# Self-Improvement Loop (Template)

## Goal
Continuously improve agent performance in this repository by capturing reusable decisions, commands, and patterns as compact artifacts that can be re-read in future sessions.

## Principles
1. Keep notes short, specific, and local to the codebase.
2. Store operational knowledge as structured snippets, not long narratives.
3. Promote repeated patterns into templates/checklists after 2-3 successful uses.
4. Prune aggressively to avoid stale or conflicting guidance.

## Directory Convention
Use a compact, discoverable layout:

```text
.agent/
  INDEX.md
  CONTINUITY.md
  CONTEXT.md
  helpers/
    INDEX.md
    TEMPLATE.md
  RUNBOOK.md
  PATTERNS.md
  DECISIONS.md
  PROMPTS.md
  execplans/
    INDEX.md
    active/
    archive/
  notes/
    YYYY-MM-DD_topic.md
```

## File Intent
1. `INDEX.md`: single entrypoint that links operating docs.
2. `CONTINUITY.md`: compaction-safe Goal/Now/Next/Open Questions + receipts.
3. `CONTEXT.md`: current architecture and constraints snapshot.
4. `helpers/INDEX.md`: index of reusable machine-facing workflow/failure helpers.
5. `helpers/TEMPLATE.md`: template for helper entries.
6. `RUNBOOK.md`: "how we do X here" commands and operational steps.
7. `PATTERNS.md`: proven coding patterns and anti-patterns.
8. `DECISIONS.md`: ADR-lite decision history (`decision`, `why`, `impact`, `date`).
9. `PROMPTS.md`: reusable prompts for repetitive agent tasks.
10. `execplans/*`: active/archive plan artifacts for larger tasks.
11. `notes/*.md`: per-task scratch notes; summarize, promote, then prune.

## Session Loop (Every Substantial Task)
1. Start: read `.agent/INDEX.md`, then `.agent/CONTINUITY.md`.
2. Context pass: read `.agent/CONTEXT.md`, `.agent/RUNBOOK.md`, `.agent/PATTERNS.md`.
3. During task: append short notes in `.agent/notes/YYYY-MM-DD_topic.md`.
4. End of task:
- Ask: "What went wrong? Why? How do we prevent it next time?"
- Update matching helper docs in `.agent/helpers/` and keep `.agent/helpers/INDEX.md` current.
- Promote repeatable rules to `RUNBOOK.md` or `PATTERNS.md`.
- Log architecture choices in `DECISIONS.md` when they are durable.
5. Update `.agent/CONTINUITY.md` with Goal/Now/Next and recent receipts.
6. Weekly prune: remove stale notes and deduplicate contradictions.

## Promotion Rules
Promote to durable docs only if one of these is true:
1. It prevented a bug or regression.
2. It saved meaningful time at least twice.
3. It defines a repo-specific constraint.
4. It changes how future tasks should be executed.

Otherwise keep it in a task note or drop it.

## Prompt Snippets
### End-of-task Learning Capture
```text
Before finishing, extract 3-7 reusable learnings from this task.
For each learning: where it applies, why it matters, and where to store it in `.agent/*`.
Then update those files with concise entries and prune outdated guidance.
```

### Repetition Detector
```text
Scan recent `.agent/notes/*` and identify repeated steps, bugs, or commands.
Propose which should be promoted into `RUNBOOK.md` or `PATTERNS.md`.
Apply updates with minimal diffs.
```

### Contradiction Check
```text
Audit `.agent/*.md` for stale assumptions or conflicting instructions.
List conflicts, propose resolution, then patch files to one consistent policy.
```

## Quality Gates for Durable Entries
Each new durable entry should include:
1. Scope (where it applies).
2. Trigger (when to use it).
3. Procedure/rule (what to do).
4. Failure mode (what breaks if ignored).

If any field is missing, keep it out of durable docs.

## Optional automation
1. Weekly automation to summarize notes, promote durable items, and prune stale entries.
2. Optional CI check that warns when `.agent/*.md` grows beyond a threshold without cleanup.
3. Starter scripts:
- `scripts/agent-weekly-review.sh`
- `scripts/agent-hygiene-check.sh`

## Success metrics
Track monthly:
1. Time-to-complete repeated task types.
2. Rework/rollback rate.
3. Number of promoted patterns reused.
4. Number of stale guidance removals.

## Pitfalls to Avoid
1. Writing long narrative notes nobody reuses.
2. Keeping contradictory guidance in multiple files.
3. Storing environment secrets in notes.
4. Turning self-improvement into overhead for tiny tasks.
