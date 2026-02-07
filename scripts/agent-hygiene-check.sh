#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

errors=0

required_files=(
  "AGENTS.md"
  ".agent/INDEX.md"
  ".agent/CONTINUITY.md"
  ".agent/CONTEXT.md"
  ".agent/WORKFLOW.md"
  ".agent/PLANS.md"
  ".agent/RUNBOOK.md"
  ".agent/PATTERNS.md"
  ".agent/DECISIONS.md"
  ".agent/PROMPTS.md"
  ".agent/helpers/INDEX.md"
  ".agent/helpers/TEMPLATE.md"
  ".agent/execplans/INDEX.md"
)

require_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    echo "ERROR: missing required file: $path"
    errors=$((errors + 1))
  fi
}

section_nonempty_count() {
  local file="$1"
  local start="$2"
  local end="$3"
  awk -v start="$start" -v end="$end" '
    $0 == start { in_section=1; next }
    $0 == end { in_section=0 }
    in_section && $0 ~ /[^[:space:]]/ { count++ }
    END { print count+0 }
  ' "$file"
}

section_bullet_count() {
  local file="$1"
  local start="$2"
  local end="$3"
  awk -v start="$start" -v end="$end" '
    $0 == start { in_section=1; next }
    $0 == end { in_section=0 }
    in_section && $0 ~ /^- / { count++ }
    END { print count+0 }
  ' "$file"
}

for path in "${required_files[@]}"; do
  require_file "$path"
done

if [[ -f ".agent/CONTINUITY.md" ]]; then
  continuity=".agent/CONTINUITY.md"
  snapshot_lines="$(section_nonempty_count "$continuity" "## Snapshot" "## Done (recent)")"
  done_bullets="$(section_bullet_count "$continuity" "## Done (recent)" "## Working set")"
  working_bullets="$(section_bullet_count "$continuity" "## Working set" "## Decisions")"
  receipt_bullets="$(section_bullet_count "$continuity" "## Receipts" "EOF-NONEXISTENT-SENTINEL")"

  if (( snapshot_lines > 25 )); then
    echo "ERROR: .agent/CONTINUITY.md Snapshot has $snapshot_lines non-empty lines (max 25)."
    errors=$((errors + 1))
  fi
  if (( done_bullets > 7 )); then
    echo "ERROR: .agent/CONTINUITY.md Done (recent) has $done_bullets bullets (max 7)."
    errors=$((errors + 1))
  fi
  if (( working_bullets > 12 )); then
    echo "ERROR: .agent/CONTINUITY.md Working set has $working_bullets bullets (max 12)."
    errors=$((errors + 1))
  fi
  if (( receipt_bullets > 20 )); then
    echo "ERROR: .agent/CONTINUITY.md Receipts has $receipt_bullets bullets (max 20)."
    errors=$((errors + 1))
  fi

  for tag in "[USER]" "[CODE]" "[TOOL]" "[ASSUMPTION]"; do
    if ! rg -q -F "$tag" "$continuity"; then
      echo "ERROR: .agent/CONTINUITY.md is missing provenance tag guidance for $tag."
      errors=$((errors + 1))
    fi
  done
fi

if [[ -f ".agent/execplans/INDEX.md" ]]; then
  if ! rg -q "^## Active ExecPlans" ".agent/execplans/INDEX.md"; then
    echo "ERROR: .agent/execplans/INDEX.md missing 'Active ExecPlans' section."
    errors=$((errors + 1))
  fi
  if ! rg -q "^## Archived ExecPlans" ".agent/execplans/INDEX.md"; then
    echo "ERROR: .agent/execplans/INDEX.md missing 'Archived ExecPlans' section."
    errors=$((errors + 1))
  fi
fi

if [[ -f "AGENTS.md" ]]; then
  if ! rg -q "\.agent/helpers/INDEX\.md" "AGENTS.md"; then
    echo "ERROR: AGENTS.md should reference .agent/helpers/INDEX.md."
    errors=$((errors + 1))
  fi
fi

if [[ -f ".agent/helpers/INDEX.md" ]]; then
  if ! rg -q "^## Active Helpers" ".agent/helpers/INDEX.md"; then
    echo "ERROR: .agent/helpers/INDEX.md missing 'Active Helpers' section."
    errors=$((errors + 1))
  fi
  if ! rg -q "^## Stable Helpers" ".agent/helpers/INDEX.md"; then
    echo "ERROR: .agent/helpers/INDEX.md missing 'Stable Helpers' section."
    errors=$((errors + 1))
  fi
  if ! rg -q "^## Retired Helpers" ".agent/helpers/INDEX.md"; then
    echo "ERROR: .agent/helpers/INDEX.md missing 'Retired Helpers' section."
    errors=$((errors + 1))
  fi
fi

if rg -q -n "/Users/[^/]+/" AGENTS.md .agent docs .github 2>/dev/null; then
  echo "ERROR: found local absolute path references; replace with repo-relative paths."
  errors=$((errors + 1))
fi

if (( errors > 0 )); then
  echo "Agent hygiene checks failed with $errors error(s)."
  exit 1
fi

echo "Agent hygiene checks passed."
