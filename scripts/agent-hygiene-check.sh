#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

default_mode="project"
settings_path=".agent/settings.toml"
mode=""
mode_source="default"

usage() {
  cat <<'USAGE'
Usage: bash scripts/agent-hygiene-check.sh [--mode template|project]
Defaults to agent.mode in .agent/settings.toml, then project.
USAGE
}

read_settings_value() {
  local path="$1"
  local section="$2"
  local key="$3"
  [[ -f "$path" ]] || return 0

  awk -v section="$section" -v key="$key" '
    BEGIN { in_agent=0 }
    /^[[:space:]]*\[/ {
      in_agent = ($0 ~ "^[[:space:]]*\\[" section "\\][[:space:]]*$")
      next
    }
    in_agent && $0 ~ "^[[:space:]]*" key "[[:space:]]*=" {
      value = $0
      sub("^[[:space:]]*" key "[[:space:]]*=[[:space:]]*", "", value)
      sub(/[[:space:]]*(#|;).*$/, "", value)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      if (value ~ /^".*"$/) {
        sub(/^"/, "", value)
        sub(/"$/, "", value)
      }
      print value
      exit
    }
  ' "$path"
}

read_settings_mode() {
  local path="$1"
  read_settings_value "$path" "agent" "mode"
}

is_valid_mode() {
  local candidate="$1"
  [[ "$candidate" == "template" || "$candidate" == "project" ]]
}

is_non_negative_int() {
  local candidate="$1"
  [[ "$candidate" =~ ^[0-9]+$ ]]
}

read_numeric_setting() {
  local key="$1"
  local fallback="$2"
  local value

  value="$(read_settings_value "$settings_path" "hygiene" "$key")"
  if [[ -z "$value" ]]; then
    echo "$fallback"
    return 0
  fi

  if is_non_negative_int "$value"; then
    echo "$value"
    return 0
  fi

  echo "WARN: invalid hygiene.$key '$value' in $settings_path; defaulting to $fallback." >&2
  echo "$fallback"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)
      if [[ $# -lt 2 ]]; then
        echo "ERROR: --mode requires a value (template|project)."
        exit 2
      fi
      mode="$2"
      mode_source="cli"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown argument: $1"
      usage
      exit 2
      ;;
  esac
done

if [[ -z "$mode" ]]; then
  settings_mode="$(read_settings_mode "$settings_path")"
  if [[ -n "$settings_mode" ]]; then
    if is_valid_mode "$settings_mode"; then
      mode="$settings_mode"
      mode_source="settings"
    else
      echo "WARN: invalid agent.mode '$settings_mode' in $settings_path; defaulting to $default_mode." >&2
      mode="$default_mode"
      mode_source="default"
    fi
  else
    mode="$default_mode"
  fi
fi

if ! is_valid_mode "$mode"; then
  echo "ERROR: invalid mode '$mode'. Use project or template."
  exit 2
fi

errors=0

continuity_snapshot_max_lines="$(read_numeric_setting "continuity_snapshot_max_lines" 25)"
continuity_done_max_bullets="$(read_numeric_setting "continuity_done_max_bullets" 7)"
continuity_working_set_max_bullets="$(read_numeric_setting "continuity_working_set_max_bullets" 12)"
continuity_receipts_max_bullets="$(read_numeric_setting "continuity_receipts_max_bullets" 20)"
max_agents_md_bytes="$(read_numeric_setting "agents_md_max_bytes" 12288)"

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
  "docs/FRAMEWORK_GUIDE.md"
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

require_only_files() {
  local dir="$1"
  shift
  local allowed=("$@")

  if [[ ! -d "$dir" ]]; then
    echo "ERROR: missing required directory: $dir"
    errors=$((errors + 1))
    return
  fi

  while IFS= read -r path; do
    local base="${path##*/}"
    local ok=0
    for allowed_name in "${allowed[@]}"; do
      if [[ "$base" == "$allowed_name" ]]; then
        ok=1
        break
      fi
    done

    if (( ok == 0 )); then
      echo "ERROR: unexpected file in template mode: $path"
      errors=$((errors + 1))
    fi
  done < <(find "$dir" -maxdepth 1 -type f | sort)
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

  if (( snapshot_lines > continuity_snapshot_max_lines )); then
    echo "ERROR: .agent/CONTINUITY.md Snapshot has $snapshot_lines non-empty lines (max $continuity_snapshot_max_lines)."
    errors=$((errors + 1))
  fi
  if (( done_bullets > continuity_done_max_bullets )); then
    echo "ERROR: .agent/CONTINUITY.md Done (recent) has $done_bullets bullets (max $continuity_done_max_bullets)."
    errors=$((errors + 1))
  fi
  if (( working_bullets > continuity_working_set_max_bullets )); then
    echo "ERROR: .agent/CONTINUITY.md Working set has $working_bullets bullets (max $continuity_working_set_max_bullets)."
    errors=$((errors + 1))
  fi
  if (( receipt_bullets > continuity_receipts_max_bullets )); then
    echo "ERROR: .agent/CONTINUITY.md Receipts has $receipt_bullets bullets (max $continuity_receipts_max_bullets)."
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
  agents_bytes="$(wc -c < "AGENTS.md" | tr -d ' ')"
  if (( agents_bytes > max_agents_md_bytes )); then
    echo "ERROR: AGENTS.md is $agents_bytes bytes (max $max_agents_md_bytes). Move long guidance into linked docs."
    errors=$((errors + 1))
  fi

  if ! rg -q "\\.agent/helpers/INDEX\\.md" "AGENTS.md"; then
    echo "ERROR: AGENTS.md should reference .agent/helpers/INDEX.md."
    errors=$((errors + 1))
  fi

  if ! rg -q "^## Discussion protocol" "AGENTS.md"; then
    echo "ERROR: AGENTS.md missing 'Discussion protocol' section."
    errors=$((errors + 1))
  fi

  if ! rg -q "^## Dependencies and commodity functionality" "AGENTS.md"; then
    echo "ERROR: AGENTS.md missing dependency evaluation section."
    errors=$((errors + 1))
  fi

  if ! rg -q "^## Definition of done" "AGENTS.md"; then
    echo "ERROR: AGENTS.md missing 'Definition of done' section."
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

if [[ "$mode" == "template" ]]; then
  require_only_files ".agent/notes" ".gitkeep" "TEMPLATE.md"
  require_only_files ".agent/helpers" "INDEX.md" "TEMPLATE.md" ".gitkeep"
  require_only_files ".agent/execplans/active" ".gitkeep" "EP-TEMPLATE.md"
  require_only_files ".agent/execplans/archive" ".gitkeep"

  if rg -q -n "^Goal:[[:space:]]+[^[:space:]]+" ".agent/CONTINUITY.md"; then
    echo "ERROR: template mode requires empty Goal in .agent/CONTINUITY.md."
    errors=$((errors + 1))
  fi
  if rg -q -n "^Now:[[:space:]]+[^[:space:]]+" ".agent/CONTINUITY.md"; then
    echo "ERROR: template mode requires empty Now in .agent/CONTINUITY.md."
    errors=$((errors + 1))
  fi
  if rg -q -n "^Next:[[:space:]]+[^[:space:]]+" ".agent/CONTINUITY.md"; then
    echo "ERROR: template mode requires empty Next in .agent/CONTINUITY.md."
    errors=$((errors + 1))
  fi
  if rg -q -n "^Open Questions:[[:space:]]+[^[:space:]]+" ".agent/CONTINUITY.md"; then
    echo "ERROR: template mode requires empty Open Questions in .agent/CONTINUITY.md."
    errors=$((errors + 1))
  fi
  if rg -q -n "^- \`[0-9]{4}-[0-9]{2}-[0-9]{2}\`" ".agent/CONTINUITY.md"; then
    echo "ERROR: template mode disallows dated continuity entries."
    errors=$((errors + 1))
  fi

  if rg -q -n "^### D-[0-9]{3}" ".agent/DECISIONS.md"; then
    echo "ERROR: template mode disallows active decision entries in .agent/DECISIONS.md."
    errors=$((errors + 1))
  fi
  if rg -q -n "^- Date: [0-9]{4}-[0-9]{2}-[0-9]{2}" ".agent/DECISIONS.md"; then
    echo "ERROR: template mode disallows dated decisions in .agent/DECISIONS.md."
    errors=$((errors + 1))
  fi

  if rg -q -n "EP-[0-9]{4}-[0-9]{2}-[0-9]{2}" ".agent/execplans/INDEX.md"; then
    echo "ERROR: template mode disallows live plan entries in .agent/execplans/INDEX.md."
    errors=$((errors + 1))
  fi

  if [[ -f "docs/AGENTIC_STARTER_FRAMEWORK.md" || -f "docs/SELF_IMPROVEMENT_LOOP.md" ]]; then
    echo "ERROR: deprecated docs detected; keep only docs/FRAMEWORK_GUIDE.md as canonical guide."
    errors=$((errors + 1))
  fi
fi

if (( errors > 0 )); then
  echo "Agent hygiene checks failed with $errors error(s) (mode: $mode)."
  exit 1
fi

echo "Agent hygiene checks passed (mode: $mode)."
