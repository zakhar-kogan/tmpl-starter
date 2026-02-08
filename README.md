# tmpl-starter

Starter repo for building an agent-friendly engineering workflow with durable project memory, phase-gated execution, and hygiene checks.

## Quick Overview

This repo is structured around a stable `/.agent` contract:

- predictable startup context for every session
- explicit task workflow phases for substantial work
- a required self-improvement loop to retain learnings
- lightweight scripts + CI checks to keep the contract healthy

If you want a reusable baseline for new projects, this repo is the scaffold.

## Structure At A Glance

```text
.
├── AGENTS.md
├── .agent/
│   ├── INDEX.md
│   ├── CONTINUITY.md
│   ├── CONTEXT.md
│   ├── WORKFLOW.md
│   ├── PLANS.md
│   ├── RUNBOOK.md
│   ├── PATTERNS.md
│   ├── DECISIONS.md
│   ├── PROMPTS.md
│   ├── helpers/
│   ├── notes/
│   └── execplans/
├── docs/
├── scripts/
└── .github/workflows/
```

## Core Functions

1. Session bootstrap
Read order is fixed: `INDEX -> CONTINUITY -> CONTEXT -> WORKFLOW -> helpers/INDEX`.

2. Phase-gated execution for substantial tasks
Follow `clarify -> plan -> implement -> validate -> capture`.

3. Self-improvement loop
At the end of substantial tasks:
- run a short failure review (`what / why / prevention`)
- add a note in `/.agent/notes/`
- promote durable learnings into `RUNBOOK`, `PATTERNS`, `DECISIONS`, and/or `helpers`
- update `CONTINUITY.md`

4. Plan lifecycle management
Major work uses plans in `/.agent/execplans/active/`, then archive completed plans.

5. Contract hygiene
Run `bash scripts/agent-hygiene-check.sh` locally and in CI (`.github/workflows/agent-hygiene.yml`).

## Getting Started

1. Clone/copy this repo as your base template.
2. Fill all `UNCONFIRMED` fields in:
- `AGENTS.md`
- `/.agent/CONTEXT.md`
- `/.agent/RUNBOOK.md`
3. Run hygiene checks:

```bash
bash scripts/agent-hygiene-check.sh
```

4. (Optional) Run weekly maintenance helper:

```bash
bash scripts/agent-weekly-review.sh
```

5. Start doing real tasks; keep the loop disciplined (especially `capture`).

## Extending This Template

Treat extensions as modular layers. Keep core `/.agent` conventions stable, and add opinionated features around them.

### Recommended Extension Areas

1. GitHub Actions / CI/CD
- add build/test/lint/typecheck workflows
- keep agent-hygiene workflow as a required guardrail

2. Tooling integrations
- issue tracker hooks
- release automation
- observability/reporting sync

3. Dev environment
- add `.devcontainer/` setup
- preinstall required CLIs and repo bootstrap commands

4. Repo-specific policy packs
- add local `AGENTS.md` in subdirectories when teams need extra constraints

### Extension Pattern (repeat for each module)

1. Add docs under `docs/` describing purpose, scope, and rollout steps.
2. Add scripts/workflows/config required by that module.
3. Update relevant `UNCONFIRMED` commands/constraints.
4. Validate with `scripts/agent-hygiene-check.sh`.
5. Record durable choices in `/.agent/DECISIONS.md`.

## Reference Docs

- Framework: `docs/AGENTIC_STARTER_FRAMEWORK.md`
- Self-improvement loop: `docs/SELF_IMPROVEMENT_LOOP.md`
- Subdirectory policy example: `docs/examples/SUBDIR_AGENTS_EXAMPLE.md`
