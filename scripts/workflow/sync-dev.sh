#!/usr/bin/env bash
set -euo pipefail

DEV_CONNECTION="${DEV_CONNECTION:-${DEV_SQLCL}}"
PROJECT_SCHEMA="${PROJECT_SCHEMA:-DIMI}"

run_sqlcl() {
  local connection="$1"
  local sql_text="$2"
  if [[ "$connection" == *"@"* ]] || [[ "$connection" == *" as sysdba"* ]]; then
    sql -S /nolog <<SQL
conn $connection
$sql_text
exit;
SQL
  else
    sql -S -name "$connection" <<SQL
$sql_text
exit;
SQL
  fi
}

run_sqlcl "$DEV_CONNECTION" "
project export -schemas $PROJECT_SCHEMA
project stage
project verify
"
