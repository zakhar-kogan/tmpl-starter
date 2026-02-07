#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo "== Agent Weekly Review =="
echo

echo "1) Running hygiene checks"
"$repo_root/scripts/agent-hygiene-check.sh"
echo

echo "2) Notes older than 30 days (review for prune/promotion)"
if find .agent/notes -type f -name "*.md" ! -name "TEMPLATE.md" -mtime +30 | grep -q .; then
  find .agent/notes -type f -name "*.md" ! -name "TEMPLATE.md" -mtime +30 | sort
else
  echo "(none)"
fi
echo

echo "3) Helpers older than 45 days (review for STABLE/RETIRED/prune)"
if find .agent/helpers -type f -name "*.md" ! -name "INDEX.md" ! -name "TEMPLATE.md" -mtime +45 | grep -q .; then
  find .agent/helpers -type f -name "*.md" ! -name "INDEX.md" ! -name "TEMPLATE.md" -mtime +45 | sort
else
  echo "(none)"
fi
echo

echo "4) Remaining UNCONFIRMED placeholders"
if rg -n "UNCONFIRMED" AGENTS.md .agent; then
  true
else
  echo "(none)"
fi
echo

echo "5) Suggested next actions"
echo "- prune stale task notes"
echo "- review helper statuses and promote stable helper rules"
echo "- promote repeated learnings into RUNBOOK/PATTERNS/DECISIONS"
echo "- update unresolved UNCONFIRMED command fields"
