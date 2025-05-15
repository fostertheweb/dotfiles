#!/usr/bin/env zsh

function create-zellij-cwd-session() {
  zellij attach --create $(basename $(pwd))
}

function zellij-create-or-attach() {
  local dir
  dir="$1"

  local session_name
  if [[ -n "$dir" ]]; then
    session_name="${dir##*/}"
  else
    return 0
  fi

  if zellij ls | grep "$session_name" 2>/dev/null; then
    if [[ -n "$ZELLIJ" ]]; then
      zellij action launch-or-focus-plugin zellij:session-manager --floating
      return 0
    else
      zellij attach "$session_name"
    fi
  else
    cd "$dir"
    zellij attach --create "$session_name"
  fi
}

local home_replacer="sed \"s|^$HOME|~|\""
local home_restore="sed \"s|^~|$HOME|\""
local find_command="fd --hidden --type d --max-depth 4 '.git' $HOME/Developer --exec dirname"

function select-git-project() {
  eval $find_command | sort -u | eval $home_replacer | fzf --keep-right --border-label " Git Projects " --prompt " : " | eval $home_restore
}

function zellij-find-and-create-or-attach() {
  zellij-create-or-attach "$(select-git-project)"
}

function zellij-list-and-attach() {
  if [[ -n "$ZELLIJ" ]]; then
    zellij action launch-or-focus-plugin zellij:session-manager --floating
    return 0
  fi

  local sessions="$(zellij list-sessions 2>/dev/null)"
  local chosen_session

  if [[ -z "$sessions" || (-n "$ZELLIJ" && $(echo "$sessions" | wc -l) -eq 1) ]]; then
    zellij-create-or-attach "$(select-git-project)"
  else
    chosen_session="$(zellij list-sessions | fzf --border-label ' Sessions ' --prompt ' : ' | cut -d' ' -f1)"
  fi

  if [[ -z "$chosen_session" ]]; then
    return 0
  fi

  zellij attach "$chosen_session"
}
