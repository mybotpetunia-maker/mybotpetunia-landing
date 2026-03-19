#!/bin/bash
# Add a log entry to logs.json and optionally push to GitHub
# Usage: ./scripts/add-log.sh --author petunia --text "Entry text here" [--push]
# Usage: ./scripts/add-log.sh -a tara -t "Entry text here" -p

set -euo pipefail
cd "$(dirname "$0")/.."

AUTHOR=""
TEXT=""
PUSH=false
DATE=$(date +%Y-%m-%d)
TIME=$(date +"%b %-d" | tr '[:upper:]' '[:lower:]')

while [[ $# -gt 0 ]]; do
  case "$1" in
    -a|--author) AUTHOR="$2"; shift 2;;
    -t|--text) TEXT="$2"; shift 2;;
    -p|--push) PUSH=true; shift;;
    -d|--date) DATE="$2"; shift 2;;
    *) echo "Unknown arg: $1"; exit 1;;
  esac
done

if [[ -z "$AUTHOR" || -z "$TEXT" ]]; then
  echo "Usage: add-log.sh --author <petunia|tara> --text \"Entry\" [--push]"
  exit 1
fi

if [[ "$AUTHOR" != "petunia" && "$AUTHOR" != "tara" ]]; then
  echo "Author must be 'petunia' or 'tara'"
  exit 1
fi

# Escape text for JSON
ESCAPED_TEXT=$(echo "$TEXT" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\t/\\t/g')

# Format time label from date
TIME=$(date -j -f "%Y-%m-%d" "$DATE" +"%b %-d" 2>/dev/null | tr '[:upper:]' '[:lower:]' || echo "$TIME")

# Build the new entry
NEW_ENTRY=$(cat <<EOF
  {
    "date": "$DATE",
    "time": "$TIME",
    "author": "$AUTHOR",
    "text": "$ESCAPED_TEXT"
  }
EOF
)

# Insert at the top of the array (after the opening bracket)
TMPFILE=$(mktemp)
# Use node for reliable JSON manipulation
node -e "
  const fs = require('fs');
  const logs = JSON.parse(fs.readFileSync('logs.json', 'utf8'));
  const entry = {
    date: '$DATE',
    time: '$TIME',
    author: '$AUTHOR',
    text: $(echo "$TEXT" | node -e "process.stdin.resume(); let d=''; process.stdin.on('data',c=>d+=c); process.stdin.on('end',()=>console.log(JSON.stringify(d.trim())))")
  };
  logs.unshift(entry);
  fs.writeFileSync('logs.json', JSON.stringify(logs, null, 2) + '\n');
"

echo "Added log entry: [$AUTHOR] $TEXT"

if $PUSH; then
  git add logs.json
  git commit -m "log: $AUTHOR entry $(date +%Y-%m-%d)"
  git push
  echo "Pushed to GitHub."
fi
