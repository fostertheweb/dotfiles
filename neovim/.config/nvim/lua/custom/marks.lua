local M = {}

M.add_global_mark = function()
  vim.ui.input({ prompt = 'Set Mark' }, function(input)
    if input == nil then
      return
    end

    if not input:match '%a' then
      vim.notify('A-Z only', vim.log.levels.WARN)
      return
    end

    local mark_char = input:upper()
    vim.cmd('normal! m' .. mark_char)
    vim.notify('Marked ' .. vim.fn.expand '%:t' .. ':' .. vim.api.nvim_win_get_cursor(0)[1])
  end)
end

M.goto_global_mark = function()
  local devicons = require 'nvim-web-devicons'
  local global_marks = {}

  -- ASCII codes for A (65) to Z (90)
  for ascii = 65, 90 do
    local mark_char = string.char(ascii)
    local pos = vim.fn.getpos("'" .. mark_char)
    -- If the line number (second element) is > 0, the mark is set.
    if pos[2] and pos[2] > 0 then
      local bufname = vim.api.nvim_buf_get_name(pos[1])
      local filename = vim.fn.fnamemodify(bufname, ':t')
      local ft_icon = devicons.get_icon_color(filename)
      local display = string.format('%s %s %s:%d', mark_char, ft_icon, filename, pos[2])
      table.insert(global_marks, { mark = mark_char, display = display })
    end
  end

  if #global_marks == 0 then
    vim.notify('No global marks set.', vim.log.levels.ERROR)
    return
  end

  vim.ui.select(global_marks, {
    prompt = 'Select Mark',
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice then
      vim.cmd("normal! '" .. choice.mark)
    end
  end)
end

return M
