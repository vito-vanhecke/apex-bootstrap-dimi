#!/usr/bin/env bash
set -euo pipefail

PLAYWRIGHT_BASE_URL="${PLAYWRIGHT_BASE_URL:-http://localhost:8181/ords/}"

npx --yes playwright@1.54.2 install chromium
PLAYWRIGHT_BASE_URL="$PLAYWRIGHT_BASE_URL" npx --yes playwright@1.54.2 test
