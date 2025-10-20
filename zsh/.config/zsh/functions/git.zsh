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

    # Create Lua script that renders directly to buffer
    cat >"/tmp/render_pr.lua" <<'LUA'
local json_str = vim.fn.system('echo ' .. vim.fn.shellescape(vim.g.pr_json))
local json = vim.fn.json_decode(json_str)

-- Create new buffer
vim.cmd('enew')
vim.bo.filetype = 'pr'

local lines = {}

-- Header
table.insert(lines, string.format("PR #%d: %s", json.number, json.title))
table.insert(lines, string.rep("=", 60))
table.insert(lines, "")

-- Author
table.insert(lines, string.format("Author: @%s", json.author.login))
table.insert(lines, "")

-- Description
table.insert(lines, "Description:")
table.insert(lines, string.rep("-", 20))
local body = json.body or "No description provided"
if body ~= vim.NIL then
    for line in body:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
end
table.insert(lines, "")

-- Files
table.insert(lines, string.format("Files Changed (%d):", #json.files))
table.insert(lines, string.rep("-", 20))
for _, file in ipairs(json.files) do
    table.insert(lines, string.format("  %s (+%d/-%d)", file.path, file.additions, file.deletions))
end
table.insert(lines, "")

-- Stats
table.insert(lines, "Statistics:")
table.insert(lines, string.rep("-", 20))
table.insert(lines, string.format("  Additions: +%d", json.additions))
table.insert(lines, string.format("  Deletions: -%d", json.deletions))
table.insert(lines, string.format("  URL: %s", json.url))

-- Set buffer content
vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
vim.bo.modified = false
LUA

    # Extract files for quickfix
    local temp_qf="/tmp/pr-$pr_number-qf.txt"
    echo "$pr_data" | jq -r --arg num "$pr_number" '.[] | select(.number == ($num | tonumber)) | .files[] | "./\(.path):1: \(.path)"' >"$temp_qf"

    # Open with quickfix and PRReview after everything loads
    nvim -c "let g:pr_json='$(echo "$pr_info" | sed "s/'/'\\''/g")'" -c "luafile /tmp/render_pr.lua" -c "cgetfile $temp_qf" -c "copen 5"
  fi
}
