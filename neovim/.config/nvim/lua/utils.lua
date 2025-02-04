local M = {}

-- move cursor to the end of a given line
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

M.move_forward = function()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local bufnr = 0
  local line_number = cursor_position[1]
  local current_column = cursor_position[2]

  vim.api.nvim_win_set_cursor(bufnr, { line_number, current_column + 1 })
end

M.move_backward = function()
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  local bufnr = 0
  local line_number = cursor_position[1]
  local current_column = cursor_position[2]
  local next_column = current_column ~= 0 and (current_column - 1) or 0

  vim.api.nvim_win_set_cursor(bufnr, { line_number, next_column })
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

M.paste = function()
  local unnamed_register = vim.fn.getreg '"'
  vim.api.nvim_put({ unnamed_register }, 'c', true, true)
end

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

M.close_tab_or_quit = function()
  if #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd 'tabclose'
  else
    vim.cmd 'quit'
  end
end

M.git_add_all = function()
  vim.fn.system 'git add --all'

  if vim.v.shell_error ~= 0 then
    vim.notify 'Nothing was staged'
  else
    vim.notify 'All changes staged'
  end
end

M.git_commit = function()
  vim.fn.system 'git commit'
  vim.cmd 'redraw'
end

return M
