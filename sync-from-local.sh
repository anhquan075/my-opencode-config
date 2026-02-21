#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="${1:-${HOME}/.config/opencode}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${SCRIPT_DIR}/opencode-config"

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "Error: source directory does not exist: ${SOURCE_DIR}"
  exit 1
fi

mkdir -p "${TARGET_DIR}"

echo "Syncing from ${SOURCE_DIR} -> ${TARGET_DIR}"
rsync -a --delete --exclude "node_modules" --exclude "*.log" --exclude ".DS_Store" "${SOURCE_DIR}/" "${TARGET_DIR}/"
echo "Done."
