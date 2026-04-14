#!/usr/bin/env bash
set -euo pipefail

VALIDATION_PDB="${VALIDATION_PDB:?VALIDATION_PDB is required}"
VALIDATION_HOST="${VALIDATION_HOST:?VALIDATION_HOST is required}"
VALIDATION_SSH_USER="${VALIDATION_SSH_USER:-root}"
VALIDATION_SSH_KEY="${VALIDATION_SSH_KEY:-$HOME/.ssh/id_rsa}"
VALIDATION_ORDS_PORT="${VALIDATION_ORDS_PORT:-8182}"
VALIDATION_ORDS_DIR="${VALIDATION_ORDS_DIR:-/root/uc-validation-ords}"
VALIDATION_ORDS_CONTAINER="${VALIDATION_ORDS_CONTAINER:-dimi-validation-ords}"

ssh -i "$VALIDATION_SSH_KEY" -o StrictHostKeyChecking=no "${VALIDATION_SSH_USER}@${VALIDATION_HOST}" \
  "VALIDATION_PDB='$VALIDATION_PDB' VALIDATION_ORDS_PORT='$VALIDATION_ORDS_PORT' VALIDATION_ORDS_DIR='$VALIDATION_ORDS_DIR' VALIDATION_ORDS_CONTAINER='$VALIDATION_ORDS_CONTAINER' bash -se" <<'REMOTE'
set -euo pipefail

mkdir -p "$VALIDATION_ORDS_DIR/ords-config" "$VALIDATION_ORDS_DIR/apex-images"
rsync -a --delete /root/uc-local-apex-dev/ords-config/ "$VALIDATION_ORDS_DIR/ords-config/"
perl -0pi -e 's{(<entry key="db\.servicename">).*?(</entry>)}{$1 . $ENV{VALIDATION_PDB} . $2}se' \
  "$VALIDATION_ORDS_DIR/ords-config/databases/default/pool.xml"

docker rm -f "$VALIDATION_ORDS_CONTAINER" >/dev/null 2>&1 || true
docker run -d \
  --name "$VALIDATION_ORDS_CONTAINER" \
  --network uc-local-apex-dev_default \
  -p "${VALIDATION_ORDS_PORT}:8080" \
  -e DEBUG=true \
  -v "$VALIDATION_ORDS_DIR/ords-config:/etc/ords/config" \
  -v /root/uc-local-apex-dev/apex-images:/opt/oracle/apex/images \
  container-registry.oracle.com/database/ords:25.4.0 >/dev/null

for _ in $(seq 1 60); do
  if curl -fsS "http://localhost:${VALIDATION_ORDS_PORT}/ords/" >/dev/null; then
    exit 0
  fi
  sleep 2
done

echo "Validation ORDS failed to become ready on port ${VALIDATION_ORDS_PORT}" >&2
docker logs "$VALIDATION_ORDS_CONTAINER" >&2 || true
exit 1
REMOTE
