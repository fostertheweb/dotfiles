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
  local pr_data selected_pr pr_number repo_name

  pr_data=$(gh pr list --json additions,author,files,deletions,id,number,title,url,createdAt,headRefName,headRepository,body)

  selected_pr=$(echo "$pr_data" | jq -r '.[] | "\u001b[36m#\(.number)\u001b[0m \(.title) \u001b[33m@\(.author.login)\u001b[0m \u001b[32m+\(.additions)\u001b[0m/\u001b[31m-\(.deletions)\u001b[0m"' | fzf --prompt="Pull Requests: " --ansi)

  if [[ -n "$selected_pr" ]]; then
    pr_number=$(echo "$selected_pr" | grep -o '^#[0-9]*' | sed 's/#//')
    repo_name=$(basename "$(pwd)")

    git fetch origin pull/$pr_number/head:pr-$pr_number
    git worktree add ../$repo_name@pr-$pr_number pr-$pr_number
    cd ../$repo_name@pr-$pr_number

    # Create temporary PR file with Lua rendering
    local pr_file="/tmp/pr-$pr_number.pr"
    local pr_info=$(echo "$pr_data" | jq -r --arg num "$pr_number" '.[] | select(.number == ($num | tonumber))')

    # Create enhanced Lua script with safe virtual text rendering
    # Create simple loader script that uses the neovim module
    cat >"/tmp/render_pr.lua" <<LUA
-- Load the PR renderer module and render the PR
local pr_renderer = require('pr_renderer')
pr_renderer.render_pr($pr_number)
LUA

    # Extract files for quickfix
    local temp_qf="/tmp/pr-$pr_number-qf.txt"
    echo "$pr_data" | jq -r --arg num "$pr_number" '.[] | select(.number == ($num | tonumber)) | .files[] | "./\(.path):1: +\(.additions) Additions -\(.deletions) Deletions"' >"$temp_qf"

    # Write PR info to temp file for safe reading
    echo "$pr_info" >"/tmp/pr-$pr_number-info.json"

    # Open with quickfix and PRReview after everything loads
    nvim -c "luafile /tmp/render_pr.lua" -c "cgetfile $temp_qf" -c "copen 5"
  fi
}
