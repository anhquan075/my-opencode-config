#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:-}"

if [[ -z "${REPO_URL}" ]]; then
  echo "Usage: bash bootstrap-install.sh <git-repo-url>"
  echo "Example: bash bootstrap-install.sh https://github.com/<you>/my-opencode-config.git"
  exit 1
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

echo "Cloning ${REPO_URL} ..."
if [[ -d "${REPO_URL}" && -f "${REPO_URL}/install.sh" ]]; then
  echo "Detected local directory source."
  bash "${REPO_URL}/install.sh"
  echo "Install complete."
  exit 0
fi

git clone --depth 1 "${REPO_URL}" "${TMP_DIR}/repo"

echo "Running installer ..."
bash "${TMP_DIR}/repo/install.sh"

echo "Install complete."
