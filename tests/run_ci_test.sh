#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_PATH="$ROOT_DIR/script_fbs.sh"

if [ ! -f "$SCRIPT_PATH" ]; then
  echo "script not found: $SCRIPT_PATH" >&2
  exit 2
fi

chmod +x "$SCRIPT_PATH"

echo "Running $SCRIPT_PATH --ci"
"$SCRIPT_PATH" --ci
RC=$?
if [ $RC -ne 0 ]; then
  echo "script exited with code $RC" >&2
  exit $RC
fi

echo "Test passed: script exited 0 in CI mode"
