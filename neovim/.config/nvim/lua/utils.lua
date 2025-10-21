local M = {}

M.open_pr_diff = function()
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

M.toggle_quickfix = function()
  local quickfix_open = false
  
  -- Check if quickfix list is open by looking at all windows
  for _, win in pairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
      quickfix_open = true
      break
    end
  end
  
  if quickfix_open then
    vim.cmd('cclose')
  else
    vim.cmd('copen')
  end
end

return M
