local M = {}

M.open_line_commit_pr_diff = function()
  local git_root = vim.fn.system 'git rev-parse --show-toplevel'
  local file_path = vim.api.nvim_buf_get_name(0)
  local relative_path = string.gsub(file_path, git_root .. '/', '')
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local command = string.format('git blame --abbrev=40 -L %d,%d %s', line_number, line_number, relative_path)
  local commit = vim.fn.system(command)
  local hash = vim.fn.system('cut -d" " -f1', commit)
  local pr_number = vim.fn.system('gh pr list --state=merged --json number --jq ".[0].number" --search=' .. hash)

  if #pr_number == 0 then
    vim.notify('No pull requests containing commit: ' .. hash)
  else
    vim.fn.system('gh pr diff --web ' .. pr_number)
  end
end

M.open_pr_diff = function()
  local gh_data = vim.b.snacks_gh

  if gh_data and gh_data.type == 'pr' then
    local url = string.format('https://github.com/%s/pull/%s', gh_data.repo, gh_data.number)
    vim.ui.open(url)
  else
    local pr_number = vim.fn.system("gh pr view --json number --jq '.number' 2>/dev/null"):gsub('%s+', '')

    if pr_number ~= '' then
      local repo = vim.fn.system('gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null'):gsub('%s+', '')
      local filepath = vim.fn.system('git ls-files --full-name ' .. vim.fn.expand '%:p'):gsub('\n', '')
      local hash = vim.fn.system("printf '%s' '" .. filepath .. "' | shasum -a 256 | cut -d' ' -f1"):gsub('%s+', '')
      local line = vim.api.nvim_win_get_cursor(0)[1]
      local url = string.format('https://github.com/%s/pull/%s/changes#diff-%sR%s', repo, pr_number, hash, line)

      vim.ui.open(url)
      vim.notify('Opening PR #' .. pr_number .. ' diff view', vim.log.levels.INFO)
    else
      M.open_line_commit_pr_diff()
    end
  end
end

M.is_dark_mode = function()
  local handle = io.popen 'osascript -e \'tell application "System Events" to tell appearance preferences to get dark mode\''

  if handle then
    local result = handle:read '*a'
    handle:close()
    return result:match 'true' ~= nil
  end

  return true
end

M.get_colors = function(hl_group)
  local hl = vim.api.nvim_get_hl(0, { name = hl_group, link = false })

  local guifg = string.format('#%06x', hl.fg or 0)
  local guibg = string.format('#%06x', hl.bg or 0)

  return {
    guifg = guifg,
    guibg = guibg,
  }
end

M.cut = function()
  local current_line = vim.api.nvim_get_current_line()
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
  -- Get the text from the cursor to the end of the line
  local cut_text = current_line:sub(cursor_col + 1)
  -- Update the line to remove the cut text
  vim.api.nvim_set_current_line(current_line:sub(1, cursor_col))
  -- Store the cut text in a register
  vim.fn.setreg('"', cut_text)
end

M.move_to_end_of_line = function()
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local bufnr = 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)

  if #lines > 0 then
    local line_length = #lines[1]
    vim.api.nvim_win_set_cursor(bufnr, { line_number, line_length })
  end
end

M.move_to_start_of_line = function()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local bufnr = 0
  local line_number = cursor_position[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)

  if #lines > 0 then
    local current_column = cursor_position[2]
    local start_column = lines[1]:find '%S'

    if current_column == start_column - 1 and current_column ~= 0 then
      vim.api.nvim_win_set_cursor(bufnr, { line_number, 0 })
    else
      vim.api.nvim_win_set_cursor(bufnr, { line_number, start_column and (start_column - 1) or 0 })
    end
  end
end

M.is_work_computer = function()
  local username = os.getenv 'USER'
  return username == 'jonathan.foster'
end

return M
