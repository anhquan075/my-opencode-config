#!/usr/bin/env bash
set -euo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
TARGET_DIR="${CONFIG_HOME}/opencode"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${CONFIG_HOME}/opencode.removed-${TIMESTAMP}"

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "Nothing to uninstall. ${TARGET_DIR} does not exist."
  exit 0
fi

echo "Backing up current config before removal: ${TARGET_DIR} -> ${BACKUP_DIR}"
cp -a "${TARGET_DIR}" "${BACKUP_DIR}"
rm -rf "${TARGET_DIR}"

echo "Removed ${TARGET_DIR}"
echo "Backup saved at ${BACKUP_DIR}"
