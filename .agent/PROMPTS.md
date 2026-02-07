# Prompts

## Task bootstrap
```text
Read .agent/INDEX.md, .agent/CONTINUITY.md, .agent/CONTEXT.md, and .agent/RUNBOOK.md.
Summarize constraints and acceptance criteria before coding.
```

## End-of-task self-improvement
```text
Before finishing, extract 3-7 reusable learnings from this task.
For each learning: where it applies, why it matters, and where to store it in `.agent/*`.
Then update those files with concise entries and prune stale or duplicate guidance.
```

## Failure review (what went wrong?)
```text
What went wrong in this task?
For each issue: root cause, early signal, and one prevention rule.
Then update .agent/RUNBOOK.md or .agent/PATTERNS.md with the prevention rule.
Also update a matching helper in `.agent/helpers/` (or add one from `.agent/helpers/TEMPLATE.md`) and register it in `.agent/helpers/INDEX.md`.
```

## Helper update after failure
```text
Review the task's failures and repeated friction points.
For each item, either:
1) update an existing helper in `.agent/helpers/`, or
2) create a new helper from `.agent/helpers/TEMPLATE.md`.
Then update `.agent/helpers/INDEX.md` with status and summary.
```

## Repetition mining
```text
Scan .agent/notes/*.md for repeated commands, bugs, or decisions.
Propose top reusable items for promotion into durable docs, then apply minimal edits.
```

## Contradiction cleanup
```text
Audit .agent/*.md for conflicting instructions or stale assumptions.
Resolve conflicts and keep one clear current policy.
```
