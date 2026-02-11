# Claude Adapter Template

Use this file for Claude-specific adapter guidance while keeping core policy in `AGENTS.md` and `/.agent/*`.

## Startup Contract

1. Read `/.agent/INDEX.md`.
2. Read `/.agent/CONTINUITY.md`.
3. Read `/.agent/CONTEXT.md`.
4. Read `/.agent/WORKFLOW.md`.
5. Read `/.agent/helpers/INDEX.md`.

Use Claude's read-first workflow for these files before editing so policy/context is loaded before actions.

## Mode Handling

1. Mode lives in `/.agent/settings.toml` (`agent.mode`).
2. `template` mode keeps scaffold files sanitized.
3. `project` mode enables full task-state capture and promotion.

## Execution Policy

1. For substantial tasks follow: `clarify -> plan -> implement -> validate -> capture`.
2. Keep diffs small and reversible.
3. Run relevant checks before finalizing and report gaps explicitly.
4. For commodity functionality, evaluate existing libraries before custom implementation.
5. Prefer minimal targeted edits over broad rewrites in policy files.

## Command Shortcuts

1. Hygiene: `make hygiene MODE=template|project`
2. Weekly review: `make review MODE=template|project`
3. Downstream repo initialization: `make init-project`
4. Before finishing substantial tasks, run hygiene in the active mode and report result.
