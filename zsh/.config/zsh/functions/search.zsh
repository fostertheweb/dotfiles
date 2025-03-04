#!/usr/bin/env zsh

function grep-cwd() {
  local selection=$(ag --hidden . | fzf -e -i)

  if [[ -n "$selection" ]]; then
    local file=$(echo "$selection" | sed -E 's/^([^:]*):([0-9]*):.*/\1/')
    local line=$(echo "$selection" | sed -E 's/^([^:]*):([0-9]*):.*/\2/')
    $EDITOR +$line "$file"
  fi
}

function find-file() {
  local selection=$(fzf)

  if [[ -n "$selection" ]]; then
    $EDITOR $selection
  fi
}
