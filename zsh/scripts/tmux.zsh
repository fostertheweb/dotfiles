#!/usr/bin/env zsh

function tmux-create-or-attach() {
  local repo
  repo="$(git rev-parse --show-toplevel 2>/dev/null)"

  local dir
  dir="$1"
  [[ -z "$dir" ]] && dir="$(pwd)"

  local session_name
  if [[ -n "$arg" ]]; then
    session_name="${arg##*/}"
  else
    if [[ -n "$repo" ]]; then
      session_name="$repo"
    else
      session_name="${dir##*/}"
    fi
  fi

  # safe session name
  session_name="${session_name//./_}"

  if tmux has-session -t "$session_name" 2>/dev/null; then
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

local home_replacer="s|^${HOME}/|~/|"
local find_command="fd -H -t d -d 4 '.git' $HOME/Developer --exec dirname | sed -e \"$home_replacer\" | sort -u"

function tmux-find-and-create-or-attach() {
  tmux-create-or-attach "$(eval $find_command | fzf --tmux)"
}

function tmux-list-and-attach() {
  local chosen_session="$(tmux list-session | fzf --tmux | cut -d: -f1)"

  if [[ -n "$TMUX" ]]; then
    local current_session="$(tmux display-message -p '#S')"
    if [[ "$chosen_session" != "$current_session" ]]; then
      tmux switch-client -t "$chosen_session"
    fi
  else
    tmux attach-session -t "$chosen_session"
  fi
}
