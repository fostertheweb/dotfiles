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
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create a floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.termopen('git commit', {
    on_exit = function(_, exit_code, _)
      if exit_code == 0 then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
  vim.cmd 'startinsert'
end

M.git_push = function()
  local output = vim.fn.system 'git push'

  if vim.v.shell_error ~= 0 then
    vim.notify 'Failed to push to remote'
  else
    vim.notify(output)
  end
end

M.has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

M.hex_to_ansi = function(hex)
  -- Remove the '#' if present.
  hex = hex:gsub('#', '')
  -- Extract the red, green, and blue components and convert them from hex to a decimal number.
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)
  -- Return the ANSI escape sequence for 24-bit (true color) foreground.
  return string.format('\27[38;2;%d;%d;%dm', r, g, b)
end

return M
