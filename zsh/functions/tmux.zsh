#!/usr/bin/env zsh

function create-tmux-cwd-session() {
  tmux new -s $(basename $(pwd))
}

function tmux-create-or-attach() {
  local dir
  dir="$1"

  local session_name
  if [[ -n "$dir" ]]; then
    session_name="${dir##*/}"
  else
    return 0
  fi

  # safe session name
  session_name="${session_name//./_}"

  if tmux has-session -t "=$session_name" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
      if [[ "$session_name" != "$(tmux display-message -p '#S')" ]]; then
        tmux switch-client -t "$session_name"
      fi
    else
      tmux attach-session -t "$session_name"
    fi
  else
    if [[ -n "$TMUX" ]]; then
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

function tmux-find-and-create-or-attach() {
  tmux-create-or-attach "$(select-git-project)"
}

function tmux-list-and-attach() {
  local sessions="$(tmux list-session 2>/dev/null)"
  local chosen_session

  if [[ -z "$sessions" || (-n "$TMUX" && $(echo "$sessions" | wc -l) -eq 1) ]]; then
    tmux-create-or-attach "$(select-git-project)"
  else
    chosen_session="$(tmux list-session | fzf --border-label ' Sessions ' --prompt ' : ' | cut -d: -f1)"
  fi

  if [[ -z "$chosen_session" ]]; then
    return 0
  fi

  if [[ -n "$TMUX" ]]; then
    local current_session="$(tmux display-message -p '#S')"
    if [[ "$chosen_session" != "$current_session" ]]; then
      tmux switch-client -t "$chosen_session"
    fi
  else
    tmux attach-session -t "$chosen_session"
  fi
}
