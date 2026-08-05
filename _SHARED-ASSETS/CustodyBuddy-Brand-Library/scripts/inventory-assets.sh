#!/usr/bin/env bash
# macOS Catalina-compatible script to inventory assets in CustodyBuddy-Brand-Library

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBRARY_DIR="$(dirname "$SCRIPT_DIR")"

echo "=========================================="
echo "CustodyBuddy Brand Library Asset Inventory"
echo "=========================================="
echo "Library Root: ${LIBRARY_DIR}"
echo ""

TOTAL_FILES=0

find "${LIBRARY_DIR}" -type d -mindepth 1 -maxdepth 2 ! -path '*/.*' ! -name 'scripts' | sort | while read -r dir; do
  COUNT=$(find "$dir" -type f ! -name '.*' ! -name '*.md' ! -name '*.json' ! -name '*.sh' | wc -l | tr -d ' ')
  DIR_NAME=$(basename "$dir")
  PARENT_NAME=$(basename "$(dirname "$dir")")
  
  if [ "$PARENT_NAME" = "$(basename "$LIBRARY_DIR")" ]; then
    echo "Directory: ${DIR_NAME} (${COUNT} files)"
  else
    echo "  └─ Subdirectory: ${PARENT_NAME}/${DIR_NAME} (${COUNT} files)"
  fi
done

TOTAL_FILES=$(find "${LIBRARY_DIR}" -type f ! -path '*/.*' ! -name '*.md' ! -name '*.json' ! -name '*.sh' | wc -l | tr -d ' ')
echo ""
echo "Total Asset Files in Master Library: ${TOTAL_FILES}"
