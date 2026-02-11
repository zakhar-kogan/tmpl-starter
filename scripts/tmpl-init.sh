#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

settings_path=".agent/settings.toml"

prompt() {
  local var_name="$1"
  local label="$2"
  local default_value="$3"
  local input=""

  read -r -p "$label [$default_value]: " input
  if [[ -z "$input" ]]; then
    printf -v "$var_name" "%s" "$default_value"
  else
    printf -v "$var_name" "%s" "$input"
  fi
}

sanitize_value() {
  local value="$1"
  value="${value//\`/}"
  printf "%s" "$value"
}

replace_prefixed_line() {
  local file="$1"
  local prefix="$2"
  local value="$3"
  local tmp_file

  tmp_file="$(mktemp)"
  awk -v prefix="$prefix" -v value="$value" '
    BEGIN { replaced=0 }
    index($0, prefix) == 1 && replaced == 0 {
      print prefix "`" value "`"
      replaced=1
      next
    }
    { print }
    END {
      if (replaced == 0) {
        exit 3
      }
    }
  ' "$file" > "$tmp_file" || {
    rm -f "$tmp_file"
    echo "ERROR: failed to update '$prefix' in $file."
    exit 1
  }

  mv "$tmp_file" "$file"
}

set_project_mode() {
  local file="$1"
  local tmp_file

  tmp_file="$(mktemp)"
  awk '
    BEGIN { in_agent=0; replaced=0 }
    /^[[:space:]]*\[/ {
      in_agent = ($0 ~ /^[[:space:]]*\[agent\][[:space:]]*$/)
      print
      next
    }
    in_agent && $0 ~ /^[[:space:]]*mode[[:space:]]*=/ {
      print "mode = \"project\""
      replaced=1
      next
    }
    { print }
    END {
      if (replaced == 0) {
        exit 3
      }
    }
  ' "$file" > "$tmp_file" || {
    rm -f "$tmp_file"
    echo "ERROR: failed to switch agent mode in $file."
    exit 1
  }

  mv "$tmp_file" "$file"
}

echo "== tmpl init =="
echo "Fill core placeholders. Press Enter to keep UNCONFIRMED."
echo

prompt project_name "Project name / what is being built" "UNCONFIRMED"
prompt target_users "Target users" "UNCONFIRMED"
prompt primary_outcomes "Primary outcomes" "UNCONFIRMED"

echo
prompt frontend_stack "Frontend stack" "UNCONFIRMED"
prompt backend_stack "Backend/API stack" "UNCONFIRMED"
prompt data_store "Data store" "UNCONFIRMED"
prompt jobs_workers "Jobs/workers" "UNCONFIRMED"
prompt hosting_deploy "Hosting/deploy" "UNCONFIRMED"

echo
prompt constraint_1 "Core constraint 1" "UNCONFIRMED"
prompt constraint_2 "Core constraint 2" "UNCONFIRMED"
prompt constraint_3 "Core constraint 3" "UNCONFIRMED"
prompt constraint_4 "Core constraint 4" "UNCONFIRMED"

echo
prompt build_cmd "Build command" "UNCONFIRMED"
prompt test_cmd "Test command" "UNCONFIRMED"
prompt lint_cmd "Lint command" "UNCONFIRMED"
prompt typecheck_cmd "Typecheck command" "UNCONFIRMED"
prompt dev_run_cmd "Dev run command" "UNCONFIRMED"

echo
prompt install_deps_cmd "Install dependencies command" "UNCONFIRMED"
prompt start_services_cmd "Start local services command" "UNCONFIRMED"
prompt run_local_cmd "Run app locally command" "UNCONFIRMED"

echo
prompt main_spec "Main spec source" "UNCONFIRMED"
prompt data_docs "Data/schema docs source" "UNCONFIRMED"
prompt roadmap "Implementation roadmap source" "UNCONFIRMED"

replace_prefixed_line ".agent/CONTEXT.md" "1. What is being built: " "$(sanitize_value "$project_name")"
replace_prefixed_line ".agent/CONTEXT.md" "2. Target users: " "$(sanitize_value "$target_users")"
replace_prefixed_line ".agent/CONTEXT.md" "3. Primary outcomes: " "$(sanitize_value "$primary_outcomes")"
replace_prefixed_line ".agent/CONTEXT.md" "1. Frontend: " "$(sanitize_value "$frontend_stack")"
replace_prefixed_line ".agent/CONTEXT.md" "2. Backend/API: " "$(sanitize_value "$backend_stack")"
replace_prefixed_line ".agent/CONTEXT.md" "3. Data store: " "$(sanitize_value "$data_store")"
replace_prefixed_line ".agent/CONTEXT.md" "4. Jobs/workers: " "$(sanitize_value "$jobs_workers")"
replace_prefixed_line ".agent/CONTEXT.md" "5. Hosting/deploy: " "$(sanitize_value "$hosting_deploy")"
replace_prefixed_line ".agent/CONTEXT.md" "1. Constraint 1: " "$(sanitize_value "$constraint_1")"
replace_prefixed_line ".agent/CONTEXT.md" "2. Constraint 2: " "$(sanitize_value "$constraint_2")"
replace_prefixed_line ".agent/CONTEXT.md" "3. Constraint 3: " "$(sanitize_value "$constraint_3")"
replace_prefixed_line ".agent/CONTEXT.md" "4. Constraint 4: " "$(sanitize_value "$constraint_4")"
replace_prefixed_line ".agent/CONTEXT.md" "1. Main spec: " "$(sanitize_value "$main_spec")"
replace_prefixed_line ".agent/CONTEXT.md" "2. Data/schema docs: " "$(sanitize_value "$data_docs")"
replace_prefixed_line ".agent/CONTEXT.md" "3. Implementation roadmap: " "$(sanitize_value "$roadmap")"

replace_prefixed_line "AGENTS.md" "1. Build command: " "$(sanitize_value "$build_cmd")"
replace_prefixed_line "AGENTS.md" "2. Test command: " "$(sanitize_value "$test_cmd")"
replace_prefixed_line "AGENTS.md" "3. Lint command: " "$(sanitize_value "$lint_cmd")"
replace_prefixed_line "AGENTS.md" "4. Typecheck command: " "$(sanitize_value "$typecheck_cmd")"
replace_prefixed_line "AGENTS.md" "5. Dev run command: " "$(sanitize_value "$dev_run_cmd")"
replace_prefixed_line "AGENTS.md" "6. Agent hygiene check: " "make hygiene MODE=project"
replace_prefixed_line "AGENTS.md" "7. Weekly maintenance review: " "make review MODE=project"

replace_prefixed_line ".agent/RUNBOOK.md" "1. Install dependencies: " "$(sanitize_value "$install_deps_cmd")"
replace_prefixed_line ".agent/RUNBOOK.md" "2. Start local services: " "$(sanitize_value "$start_services_cmd")"
replace_prefixed_line ".agent/RUNBOOK.md" "3. Run app locally: " "$(sanitize_value "$run_local_cmd")"
replace_prefixed_line ".agent/RUNBOOK.md" "1. Build: " "$(sanitize_value "$build_cmd")"
replace_prefixed_line ".agent/RUNBOOK.md" "2. Test: " "$(sanitize_value "$test_cmd")"
replace_prefixed_line ".agent/RUNBOOK.md" "3. Lint: " "$(sanitize_value "$lint_cmd")"
replace_prefixed_line ".agent/RUNBOOK.md" "4. Typecheck: " "$(sanitize_value "$typecheck_cmd")"

set_project_mode "$settings_path"

echo
echo "Initialized core placeholders and switched .agent/settings.toml to project mode."
if ! bash scripts/agent-hygiene-check.sh --mode project; then
  echo "WARN: hygiene checks are still failing in project mode; resolve remaining issues."
fi
echo "Next: resolve any remaining UNCONFIRMED fields."
