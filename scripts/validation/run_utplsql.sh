#!/usr/bin/env bash
set -euo pipefail

VALIDATION_CONNECTION="${VALIDATION_CONNECTION:-VALIDATION}"

if [[ ! -f tests/utplsql/run.sql ]]; then
  echo "Missing tests/utplsql/run.sql"
  exit 1
fi

if [[ "$VALIDATION_CONNECTION" == *"@"* ]] || [[ "$VALIDATION_CONNECTION" == *" as sysdba"* ]]; then
  sql -S /nolog <<SQL
conn $VALIDATION_CONNECTION
@tests/utplsql/run.sql
exit;
SQL
else
  sql -S -name "$VALIDATION_CONNECTION" @tests/utplsql/run.sql
fi
