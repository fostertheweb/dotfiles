#!/usr/bin/env zsh

local terminal="/Applications/Ghostty.app"
local home_replacer="sed \"s|^$HOME|~|\""
local home_restore="sed \"s|^~|$HOME|\""
local find_command="fd --hidden --type d --max-depth 4 '.git' $HOME/Developer --exec dirname"
local fzf_git_cmd="fzf --header '  Projects' --keep-right ${TMUX:+--border sharp}"

function select-git-project() {
  eval $find_command | sort -u | eval $home_replacer | eval $fzf_git_cmd | eval $home_restore
}

function create-named-workspace() {
  local dir

  if [[ -z $1 ]]; then
    return 0
  fi

  dir=$1

  aerospace workspace $(basename $dir)
  open -na "Ghostty.app" $dir
}

function create-or-goto-workspace() {
  local dir
  dir=$1

  local session_name
  if [[ -n $dir ]]; then
    session_name="${dir##*/}"
  else
    return 0
  fi

  workspaces=$(aerospace list-workspaces --all 2>/dev/null)

  if echo "$workspaces" | grep -x "$session_name"; then
    aerospace workspace "$session_name"

    windows=$(aerospace list-windows --workspace $session_name)

    if [[ -z $windows ]]; then
      open -na "Ghostty.app" $dir
    fi
  else
    create-named-workspace $dir
  fi

  return 0
}

function find-and-create-or-goto-workspace() {
  create-or-goto-workspace "$(select-git-project)"
}

function list-workspaces-and-goto-or-create() {
  local chosen_workspace
  local workspaces="$(aerospace list-workspaces --all | grep -vE '^[[:space:]]*[0-9]+[[:space:]]*$')"
  local fzf_cmd="fzf --header '  Workspaces'"
  local current_workspace="$(aerospace list-workspaces --focused)"

  if [[ -z $workspaces ]]; then
    create-named-workspace $(select-git-project)
  else
    if [[ $(echo "$workspaces" | wc -l) -eq 1 ]]; then
      # check if the only workspace is the current one
      # local only_workspace=$(echo "$workspaces" | head -n 1)
      create-or-goto-workspace $(select-git-project)
    else
      chosen_workspace=$(echo $workspaces | eval $fzf_cmd)

      if [[ -z $chosen_workspace ]]; then
        return 0
      fi

      aerospace workspace $chosen_workspace
    fi
  fi

}

# ctrl-t
# List current sessions and attach
bindkey -s '^T' 'list-workspaces-and-goto-or-create^M'

# cmd-o
# Find project and create or attach
bindkey -s '\eo' 'find-and-create-or-goto-workspace^M'

# cmd-s
# Create new session
bindkey -s '\es' 'create-named-workspace $(pwd)^M'
