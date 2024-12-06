#!/usr/bin/env zsh 

function create-worktree() {
  if [[ -z "$1" ]]; then
    echo "Error: New worktree name required" >&2
    return 1
  fi

  local trunk=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
  local worktree=$(pwd | sed "s/$(basename "$(pwd)")/$(basename $(pwd))@$1/")
  git worktree add $worktree $trunk
  cd $worktree
  git status
}
