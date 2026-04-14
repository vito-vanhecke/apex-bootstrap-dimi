#!/usr/bin/env bash
set -euo pipefail

STAGE_CONNECTION="${STAGE_CONNECTION:-${DEV_CONNECTION:-${DEV_SQLCL}}}"
DEV_CONNECTION="${DEV_CONNECTION:-${DEV_SQLCL}}"
PROMOTE_VERSION="${1:-${BUILD_NUMBER:-snapshot}}"
ARTIFACT_FILE="${2:-}"

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

if [[ -z "$ARTIFACT_FILE" ]]; then
  SQL_TEXT=$(cat <<SQL
project stage
project verify
project gen-artifact -version "$PROMOTE_VERSION"
SQL
)
  run_sqlcl "$STAGE_CONNECTION" "$SQL_TEXT"
  ARTIFACT_FILE="$(ls -1 artifacts/*.zip 2>/dev/null | sort | tail -n 1)"
fi

if [[ -z "$ARTIFACT_FILE" ]]; then
  echo "No artifact file found under artifacts/"
  exit 1
fi

SQL_TEXT=$(cat <<SQL
project deploy -file "$ARTIFACT_FILE"
SQL
)

run_sqlcl "$DEV_CONNECTION" "$SQL_TEXT"
