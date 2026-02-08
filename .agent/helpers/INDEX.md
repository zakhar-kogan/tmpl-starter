# Helper Index

Machine-facing helper memory for recurring failures and repeatable workflows.

## Usage
1. Read this index at task startup.
2. Reuse existing helpers when triggers match.
3. After a failure review, update an existing helper or add a new one.
4. Keep entries short and operational; promote stable guidance into `RUNBOOK.md` or `PATTERNS.md`.

## Entry format
- `H-YYYY-MM-DD__slug` — `Status:<ACTIVE|STABLE|RETIRED>` — `Path:<repo-relative path>` — `Scope:<where it applies>` — `Summary:<one line>`

## Active Helpers
- `H-2026-02-07__postmortem-to-helper-update` — `Status:ACTIVE` — `Path:/.agent/helpers/H-2026-02-07__postmortem-to-helper-update.md` — `Scope:substantial tasks` — `Summary:convert failure reviews into updated helper playbooks`

## Stable Helpers
- (none yet)

## Retired Helpers
- (none yet)
