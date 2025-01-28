#!/usr/bin/env zsh

function create-zellij-cwd-session() {
  zellij -s $(basename $(pwd))
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

  if tmux has-session -t "=$session_name" 2>/dev/null; then
    if [[ -n "$ZELLIJ" ]]; then
      if [[ "$session_name" != "$(tmux display-message -p '#S')" ]]; then
        tmux switch-client -t "$session_name"
      fi
    else
      tmux attach-session -t "$session_name"
    fi
  else
    if [[ -n "$ZELLIJ" ]]; then
      tmux new-session -d -s "$session_name" -c "$dir"
      tmux switch-client -t "$session_name"
    else
      tmux new-session -s "$session_name" -c "$dir"
    fi
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
  local sessions="$(tmux list-session 2>/dev/null)"
  local chosen_session

  if [[ -z "$sessions" || (-n "$ZELLIJ" && $(echo "$sessions" | wc -l) -eq 1) ]]; then
    zellij-create-or-attach "$(select-git-project)"
  else
    chosen_session="$(zellij list-sessions | fzf --border-label ' Sessions ' --prompt ' : ' | cut -d' ' -f1)"
  fi

  if [[ -z "$chosen_session" ]]; then
    return 0
  fi

  if [[ -n "$ZELLIJ" ]]; then
    local current_session="$(tmux display-message -p '#S')"
    if [[ "$chosen_session" != "$current_session" ]]; then
      tmux switch-client -t "$chosen_session"
    fi
  else
    tmux attach-session -t "$chosen_session"
  fi
}
