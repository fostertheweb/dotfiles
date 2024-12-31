local M = {}

-- move cursor to the end of a given line
M.move_to_end_of_line = function(line_number)
  local bufnr = 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)

  if #lines > 0 then
    local line_length = #lines[1]
    vim.api.nvim_win_set_cursor(bufnr, { line_number, line_length })
  end
end

M.move_to_start_of_line = function(cursor_position)
  local bufnr = 0
  local line_number = cursor_position[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)

  if #lines > 0 then
    local current_column = cursor_position[2]
    local start_column = lines[1]:find '%S'

    if current_column == start_column and current_column ~= 1 then
      vim.api.nvim_win_set_cursor(bufnr, { line_number, 0 })
    else
      vim.api.nvim_win_set_cursor(bufnr, { line_number, start_column and (start_column - 1) or 0 })
    end
  end
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

-- State variables
local timer = nil
local keypress_count = 0
local threshold_ms = 750

local handle_keypress = function()
  keypress_count = keypress_count + 1

  if not timer then
    timer = vim.loop.new_timer()
  end

  if timer then
    timer:stop()
    timer:start(
      threshold_ms,
      0,
      vim.schedule_wrap(function()
        if keypress_count == 1 then
          -- Single keypress action
          print 'Single keypress action executed!'
        elseif keypress_count > 1 then
          -- Multiple keypress action
          print 'Multiple keypress action executed!'
        end
        -- Reset state
        keypress_count = 0
        timer:stop()
      end)
    )
  end
end

return M
