#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/opencode-config"
CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
TARGET_DIR="${CONFIG_HOME}/opencode"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${CONFIG_HOME}/opencode.backup-${TIMESTAMP}"

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "Error: ${SOURCE_DIR} not found."
  exit 1
fi

mkdir -p "${CONFIG_HOME}"

if [[ -d "${TARGET_DIR}" ]]; then
  echo "Backing up existing config: ${TARGET_DIR} -> ${BACKUP_DIR}"
  cp -a "${TARGET_DIR}" "${BACKUP_DIR}"
fi

echo "Installing OpenCode config to ${TARGET_DIR}"
rsync -a --delete --exclude "node_modules" --exclude "*.log" --exclude ".DS_Store" "${SOURCE_DIR}/" "${TARGET_DIR}/"

echo "Done."
echo "- Installed: ${TARGET_DIR}"
if [[ -d "${BACKUP_DIR}" ]]; then
  echo "- Backup:    ${BACKUP_DIR}"
fi
echo "Restart OpenCode to pick up all changes."
