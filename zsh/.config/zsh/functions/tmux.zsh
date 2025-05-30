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
local fzf_git_cmd="fzf --header '  Projects' --keep-right ${TMUX:+--border sharp}"

function select-git-project() {
  eval $find_command | sort -u | eval $home_replacer | eval $fzf_git_cmd | eval $home_restore
}

function tmux-find-and-create-or-attach() {
  tmux-create-or-attach "$(select-git-project)"
}

function tmux-list-and-attach() {
  local sessions="$(tmux list-session 2>/dev/null)"
  local chosen_session
  local fzf_cmd="fzf --header '  Sessions' ${TMUX:+--border sharp}"

  if [[ -z "$sessions" || (-n "$TMUX" && $(echo "$sessions" | wc -l) -eq 1) ]]; then
    tmux-create-or-attach "$(select-git-project)"
  else
    chosen_session="$(tmux list-session | eval $fzf_cmd | cut -d: -f1)"
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

# ctrl-t
# List current sessions and attach
bindkey -s '^T' 'tmux-list-and-attach^M'

# cmd-o
# Find project and create or attach
bindkey -s '\eo' 'tmux-find-and-create-or-attach^M'

# cmd-s
# Create tmux session
bindkey -s '\es' 'create-tmux-cwd-session^M'
