#!/bin/sh
set -eu

URL="https://raw.githubusercontent.com/yaakauna/adlist/main/adblockmosdns.txt"
DEST="/etc/mosdns/rule/adblockmosdns.txt"
TMP="${DEST}.tmp"

cleanup() {
  rm -f "$TMP"
}
trap cleanup EXIT INT TERM

curl --fail --location --silent --show-error \
  --connect-timeout 20 --max-time 180 \
  "$URL" -o "$TMP"

grep -q '^# Title: AdBlock MosDNS$' "$TMP"
count="$(grep -cv '^[[:space:]]*\(#\|$\)' "$TMP")"
[ "$count" -gt 100000 ]

if cmp -s "$TMP" "$DEST"; then
  printf 'Ad list unchanged (%s domains)\n' "$count"
  exit 0
fi

mv "$TMP" "$DEST"
trap - EXIT INT TERM
/etc/init.d/mosdns restart
printf 'Ad list updated and MosDNS restarted (%s domains)\n' "$count"
