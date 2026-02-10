# tmpl-starter

Agent workflow framework template with:
- a stable `/.agent` contract
- phase-gated execution for substantial tasks
- mode-aware hygiene checks (`template` vs `project`)

This is not an application boilerplate (no runtime stack, no app scaffolding).

## Quickstart Checklist (After Cloning)

1. Initialize your project metadata and switch to project mode:

```bash
make init-project
```

2. Review and finish any remaining `UNCONFIRMED` placeholders:
- `AGENTS.md`
- `/.agent/CONTEXT.md`
- `/.agent/RUNBOOK.md`

3. Validate scaffold hygiene while still template-like:

```bash
make hygiene MODE=template
make review MODE=template
```

4. Validate downstream project workflow behavior:

```bash
make hygiene MODE=project
make review MODE=project
```

5. Start using the contract in daily work:
- startup order: `INDEX -> CONTINUITY -> CONTEXT -> WORKFLOW -> helpers/INDEX`
- substantial task flow: `clarify -> plan -> implement -> validate -> capture`

## Repository Modes

- `template` mode: scaffold stays sanitized (no live task-state writes in continuity/decisions/notes/helpers/execplans)
- `project` mode: downstream cloned repos enable full self-improving capture loop

Mode defaults live in `/.agent/settings.toml`.

## License Scope

`LICENSE` covers this workflow template framework. Downstream projects can keep MIT or choose a different license policy for their own code.

## Reference Docs

- Canonical framework guide: `docs/FRAMEWORK_GUIDE.md`
- Subdirectory policy example: `docs/examples/SUBDIR_AGENTS_EXAMPLE.md`
