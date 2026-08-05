#!/usr/bin/env bash
# macOS Catalina-compatible helper script to safely copy assets to local projects

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBRARY_DIR="$(dirname "$SCRIPT_DIR")"

DESTINATION=""
CATEGORY=""
OVERWRITE=0
DRY_RUN=0

usage() {
  echo "Usage: $0 --destination <path> [--category <brand|backgrounds|product|audio|icons>] [--overwrite] [--dry-run]"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --destination)
      DESTINATION="$2"
      shift 2
      ;;
    --category)
      CATEGORY="$2"
      shift 2
      ;;
    --overwrite)
      OVERWRITE=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    *)
      usage
      ;;
  esac
done

if [ -z "$DESTINATION" ]; then
  echo "Error: Missing required argument --destination"
  usage
fi

TARGET_DIR="${DESTINATION}/assets/shared/custodybuddy"

echo "=========================================="
echo "CustodyBuddy Asset Helper: Copy to Project"
echo "=========================================="
echo "Source Library : ${LIBRARY_DIR}"
echo "Destination    : ${TARGET_DIR}"
if [ $DRY_RUN -eq 1 ]; then
  echo "Mode           : DRY RUN (No changes will be made)"
fi
echo "=========================================="

if [ $DRY_RUN -eq 0 ]; then
  mkdir -p "${TARGET_DIR}"
fi

# Determine source directories
SOURCE_PATHS=()
if [ -n "$CATEGORY" ]; then
  case "$CATEGORY" in
    brand) SOURCE_PATHS+=("${LIBRARY_DIR}/01-BRAND") ;;
    backgrounds) SOURCE_PATHS+=("${LIBRARY_DIR}/02-BACKGROUNDS") ;;
    product) SOURCE_PATHS+=("${LIBRARY_DIR}/03-PRODUCT") ;;
    icons) SOURCE_PATHS+=("${LIBRARY_DIR}/06-ICONS") ;;
    audio) SOURCE_PATHS+=("${LIBRARY_DIR}/07-AUDIO") ;;
    *) echo "Unknown category: $CATEGORY"; exit 1 ;;
  esac
else
  SOURCE_PATHS+=("${LIBRARY_DIR}/01-BRAND" "${LIBRARY_DIR}/02-BACKGROUNDS" "${LIBRARY_DIR}/03-PRODUCT" "${LIBRARY_DIR}/06-ICONS" "${LIBRARY_DIR}/07-AUDIO")
fi

COPIED_COUNT=0
SKIPPED_COUNT=0

for src in "${SOURCE_PATHS[@]}"; do
  if [ -d "$src" ]; then
    while read -r file; do
      REL_PATH="${file#"${LIBRARY_DIR}/"}"
      FILENAME=$(basename "$file")
      DEST_FILE="${TARGET_DIR}/${FILENAME}"

      if [ -f "$DEST_FILE" ] && [ $OVERWRITE -eq 0 ]; then
        echo "SKIPPED (File exists): ${FILENAME}"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
      else
        echo "COPYING: ${REL_PATH} -> ${DEST_FILE}"
        if [ $DRY_RUN -eq 0 ]; then
          cp "$file" "$DEST_FILE"
        fi
        COPIED_COUNT=$((COPIED_COUNT + 1))
      fi
    done < <(find "$src" -type f ! -name '.*' ! -name '*.md' ! -name '*.json')
  fi
done

echo ""
echo "Summary:"
echo "  Copied : ${COPIED_COUNT}"
echo "  Skipped: ${SKIPPED_COUNT}"

if [ $DRY_RUN -eq 0 ] && [ $COPIED_COUNT -gt 0 ]; then
  MANIFEST_FILE="${TARGET_DIR}/copied-assets-manifest.json"
  DATE_NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  cat <<EOF > "$MANIFEST_FILE"
{
  "copiedAt": "${DATE_NOW}",
  "sourceLibrary": "${LIBRARY_DIR}",
  "copiedFilesCount": ${COPIED_COUNT}
}
EOF
  echo "Created manifest: ${MANIFEST_FILE}"
fi
