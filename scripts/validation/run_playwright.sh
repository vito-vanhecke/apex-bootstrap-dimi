#!/usr/bin/env bash
set -euo pipefail

PLAYWRIGHT_BASE_URL="${PLAYWRIGHT_BASE_URL:-http://localhost:8181/ords/}"

if [[ ! -f package.json ]]; then
  echo "Missing package.json for Playwright validation"
  exit 1
fi

if [[ ! -f node_modules/@playwright/test/package.json ]]; then
  npm install --no-fund --no-audit --no-package-lock
fi

npx playwright install chromium
PLAYWRIGHT_BASE_URL="$PLAYWRIGHT_BASE_URL" npx playwright test
