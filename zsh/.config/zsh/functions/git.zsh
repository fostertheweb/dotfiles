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
    cat >"/tmp/render_pr.lua" <<LUA
-- Read PR info from temp file for safe JSON handling  
local pr_number = $pr_number
local pr_file = "/tmp/pr-" .. pr_number .. "-info.json"
if vim.fn.filereadable(pr_file) == 0 then
  error("PR info file not found: " .. pr_file)
end
-- Read the entire file and join lines to preserve JSON structure
local json_lines = vim.fn.readfile(pr_file)
local json_str = table.concat(json_lines, "\n")
local json = vim.fn.json_decode(json_str)

-- Set up PR highlights
local highlights = {
  { 'PRTitle', { fg = '#58a6ff', bold = true } },
  { 'PRNumber', { fg = '#8b949e', italic = true } },
  { 'PRState', { fg = '#238636', bold = true } },
  { 'PRUser', { fg = '#ffffff', bg = '#21262d', bold = true } },
  { 'PRLabel', { fg = '#58a6ff', bold = true } },
  { 'PRStatsGreen', { fg = '#238636', bold = true } },
  { 'PRStatsRed', { fg = '#da3633', bold = true } },
  { 'PRSection', { fg = '#f0f6fc', bold = true } },
  { 'PRFile', { fg = '#e6edf3' } },
}

for _, hl in ipairs(highlights) do
  vim.api.nvim_set_hl(0, hl[1], hl[2])
end

-- Create temporary file buffer
local temp_file = "/tmp/pr-" .. json.number .. ".pr"
vim.cmd('edit ' .. temp_file)
vim.bo.filetype = 'pullrequest'
local ns = vim.api.nvim_create_namespace('pr_virtual_text')

-- Build content with proper line tracking
local lines = {}
local line_map = {}  -- Track what each line represents

-- Line 0: PR number and title 
local title_line = string.format("PR #%d: %s", json.number, json.title)
table.insert(lines, title_line)
line_map[#lines] = { type = 'title', data = json }

-- Line 1: Author 
local author_line = string.format("@%s", json.author.login)
table.insert(lines, author_line)
line_map[#lines] = { type = 'author', data = json.author }

-- Line 2: Stats
local stats_line = string.format("+%d -%d", json.additions, json.deletions)
table.insert(lines, stats_line)
line_map[#lines] = { type = 'stats', data = { additions = json.additions, deletions = json.deletions } }

-- Line 3: Empty
table.insert(lines, "")

-- Line 4: Description header
table.insert(lines, "Description")
line_map[#lines] = { type = 'section_header', text = 'Description' }

-- Description content
local body = json.body or "No description provided"
if body ~= vim.NIL and body ~= "" then
  for line in body:gmatch("[^\r\n]+") do
    table.insert(lines, line)
    line_map[#lines] = { type = 'description' }
  end
else
  table.insert(lines, "No description provided")
  line_map[#lines] = { type = 'description' }
end

-- Empty line
table.insert(lines, "")

-- Files header
local files_header = string.format("Files Changed (%d)", #json.files)
table.insert(lines, files_header)
line_map[#lines] = { type = 'section_header', text = files_header }

-- File list
for _, file in ipairs(json.files) do
  table.insert(lines, file.path)
  line_map[#lines] = { type = 'file', data = file }
end

-- Empty line and URL
table.insert(lines, "")
table.insert(lines, json.url)
line_map[#lines] = { type = 'url', data = json.url }

-- Set buffer content
vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

-- Apply virtual text formatting immediately (no vim.schedule)
for line_idx, line_info in pairs(line_map) do
  local zero_indexed = line_idx - 1  -- Convert to 0-indexed for extmarks
  
  if line_info.type == 'title' then
    vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
      virt_text = { { title_line, 'PRTitle' } },
      virt_text_pos = 'overlay'
    })
  elseif line_info.type == 'author' then
    vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
      virt_text = { { '  ' .. author_line .. '  ', 'PRUser' } },
      virt_text_pos = 'overlay'
    })
  elseif line_info.type == 'stats' then
    vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
      virt_text = {
        { '+' .. line_info.data.additions, 'PRStatsGreen' },
        { ' -' .. line_info.data.deletions, 'PRStatsRed' }
      },
      virt_text_pos = 'overlay'
    })
  elseif line_info.type == 'section_header' then
    vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
      virt_text = { { line_info.text, 'PRSection' } },
      virt_text_pos = 'overlay'
    })
  elseif line_info.type == 'file' then
    vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
      virt_text = { { line_info.data.path, 'PRFile' } },
      virt_text_pos = 'overlay'
    })
    vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
      virt_text = {
        { ' +' .. line_info.data.additions, 'PRStatsGreen' },
        { ' -' .. line_info.data.deletions, 'PRStatsRed' }
      },
      virt_text_pos = 'eol'
    })
  elseif line_info.type == 'url' then
    vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
      virt_text = { { line_info.data, 'PRLabel' } },
      virt_text_pos = 'overlay'
    })
  end
end

-- Save and set as readonly
vim.cmd('write')
vim.bo.modified = false
vim.bo.readonly = true
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
