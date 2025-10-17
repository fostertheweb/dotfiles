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

function select-git-branch() {
  local fzf_cmd="fzf --keep-right --border-label \" Checkout Branch \" --prompt \" : \""
  git branch -v | eval $fzf_cmd | sed -E 's/^[* ]+([a-zA-Z0-9_-]+).*/\1/' | xargs git checkout
}

function origin-status() {
  if [[ -n $1 ]]; then
    z $1
  fi

  git fetch origin

  local trunk=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
  read -r ahead behind <<<$(git rev-list --left-right --count HEAD...origin/$trunk)
  local output="$behind behind, $ahead ahead"
  local merge_dry_run=$(git merge --no-commit --no-ff --dry-run origin/main 2>&1)

  if echo "$merge_dry_run" | grep -q 'CONFLICT'; then
    output="$output with conflicts"
  fi

  echo $output
}

function pull-requests() {
  local pr_data selected_pr pr_number files

  pr_data=$(gh pr list --json additions,author,files,deletions,id,number,title,url,createdAt,headRefName,headRepository)

  selected_pr=$(echo "$pr_data" | jq -r '.[] | "#\(.number) \(.title) @\(.author.login) +\(.additions)/-\(.deletions)"' | fzf --prompt="Select PR: ")

  if [[ -n "$selected_pr" ]]; then
    pr_number=$(echo "$selected_pr" | grep -o '^#[0-9]*' | sed 's/#//')

    files=$(echo "$pr_data" | jq -r --arg num "$pr_number" '.[] | select(.number == ($num | tonumber)) | .files[].path')

    echo "$files" | fzf --prompt="Select file: "
  fi
}
