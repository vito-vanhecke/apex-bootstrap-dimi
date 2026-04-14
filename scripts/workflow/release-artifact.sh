#!/usr/bin/env bash
set -euo pipefail

DEV_CONNECTION="${DEV_CONNECTION:-${DEV_SQLCL}}"
RELEASE_VERSION="${1:-${BUILD_NUMBER:-snapshot}}"

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
project release -version "$RELEASE_VERSION"
project gen-artifact -version "$RELEASE_VERSION"
SQL
)

run_sqlcl "$DEV_CONNECTION" "$SQL_TEXT"
