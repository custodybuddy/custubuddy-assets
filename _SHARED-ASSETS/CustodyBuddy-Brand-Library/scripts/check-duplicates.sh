#!/usr/bin/env bash
# macOS Catalina-compatible script to check for exact SHA-256 duplicate files

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIBRARY_DIR="$(dirname "$SCRIPT_DIR")"

echo "Checking for exact SHA-256 duplicates in: ${LIBRARY_DIR}"
echo "--------------------------------------------------------"

TMP_FILE=$(mktemp /tmp/cb_hashes.XXXXXX)
trap 'rm -f "$TMP_FILE"' EXIT

find "${LIBRARY_DIR}" -type f ! -path '*/.*' ! -name '*.md' ! -name '*.json' ! -name '*.sh' -exec shasum -a 256 {} + > "$TMP_FILE"

DUPLICATES=$(awk '{print $1}' "$TMP_FILE" | sort | uniq -d)

if [ -z "$DUPLICATES" ]; then
  echo "No exact SHA-256 duplicate assets found."
else
  echo "Found duplicate file content matching the following SHA-256 checksums:"
  echo ""
  for hash in $DUPLICATES; do
    echo "Hash: $hash"
    grep "^$hash" "$TMP_FILE" | awk '{ $1=""; print "  -" $0 }'
    echo ""
  done
  echo "Note: Duplicates should be logged in 98-DUPLICATES without deleting original references."
fi
