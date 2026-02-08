# Project Context

## Product
1. What is being built: reusable agentic-starter scaffolding for repository process memory, workflow gating, and hygiene checks.
2. Target users: engineers and agent operators bootstrapping new repositories with consistent `.agent` conventions.
3. Primary outcomes: fast startup context loading, repeatable task capture, and enforceable maintenance hygiene.

## Architecture
1. Frontend: none (documentation/template repository).
2. Backend/API: none (bash scripts + markdown operational contract).
3. Data store: git-tracked markdown files under `/.agent/` and `docs/`.
4. Jobs/workers: GitHub Actions workflow (`.github/workflows/agent-hygiene.yml`) running hygiene checks.
5. Hosting/deploy: GitHub repository used as a template or copied baseline.

## Core Constraints
1. Constraint 1: keep the `/.agent/` contract layout and startup order stable across updates.
2. Constraint 2: keep continuity compact (size caps) and provenance-tagged.
3. Constraint 3: avoid machine-local absolute paths in tracked docs/scripts.
4. Constraint 4: do not require host-level package installation for baseline maintenance tasks.

## Current Source of Truth
1. Main spec: `docs/AGENTIC_STARTER_FRAMEWORK.md`.
2. Data/schema docs: `N/A (no app data model; structure documented in `.agent/*.md`).`
3. Implementation roadmap: `docs/SELF_IMPROVEMENT_LOOP.md` and `/.agent/WORKFLOW.md`.
