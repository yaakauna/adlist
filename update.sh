#!/bin/sh
set -eu

SOURCE_URL="https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockmosdns.txt"
OUTPUT="${1:-adblockmosdns.txt}"
TMP="${OUTPUT}.tmp"

cleanup() {
  rm -f "$TMP"
}
trap cleanup EXIT INT TERM

curl --fail --location --silent --show-error \
  --connect-timeout 20 --max-time 180 \
  "$SOURCE_URL" -o "$TMP"

grep -q '^# Title: AdBlock MosDNS$' "$TMP"
count="$(grep -cv '^[[:space:]]*\(#\|$\)' "$TMP")"
[ "$count" -gt 100000 ]

mv "$TMP" "$OUTPUT"
trap - EXIT INT TERM
printf 'Updated %s with %s domains\n' "$OUTPUT" "$count"
