#!/usr/bin/env zsh

function create-or-open-journal-entry() {
  NOTES_DIR="$HOME/Documents/Journal"
  DATE_FORMAT="%Y-%m-%d" # YYYY-MM-DD

  mkdir -p "$NOTES_DIR"

  current_date=$(date +"$DATE_FORMAT")
  file_path="$NOTES_DIR/${current_date}.md"

  # Create file if it doesn't exist
  if [[ ! -f "$file_path" ]]; then
    cat >"$file_path" <<EOF
# $current_date

## Tasks
- [ ] 

EOF
    echo "Created new entry: $file_path"
  else
    echo "Opening today's entry: $file_path"
  fi

  nvim "$file_path"
}
