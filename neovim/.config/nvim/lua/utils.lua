local M = {}

-- move cursor to the end of a given line
M.move_to_end_of_line = function(line_number)
  local bufnr = 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)

  if #lines > 0 then
    local line_length = #lines[1]
    vim.api.nvim_win_set_cursor(0, { line_number, line_length })
  end
end

return M
