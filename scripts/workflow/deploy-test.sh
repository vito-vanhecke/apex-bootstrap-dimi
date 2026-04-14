#!/usr/bin/env bash
set -euo pipefail

TEST_CONNECTION="${TEST_CONNECTION:-${TEST_SQLCL}}"
ARTIFACT_FILE="${1:-$(ls -1 artifacts/*.zip 2>/dev/null | sort | tail -n 1)}"

if [[ -z "${ARTIFACT_FILE}" ]]; then
  echo "No artifact file found under artifacts/"
  exit 1
fi

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

SQL_TEXT=$(cat <<SQL
project deploy -file "$ARTIFACT_FILE"
SQL
)

run_sqlcl "$TEST_CONNECTION" "$SQL_TEXT"
