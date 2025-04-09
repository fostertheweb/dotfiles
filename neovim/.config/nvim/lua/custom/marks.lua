local M = {}

M.get_global_marks = function()
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
      table.insert(global_marks, { mark = mark_char, bufname = bufname, display = display })
    end
  end

  return global_marks
end

M.add_global_mark = function()
  vim.notify = require('mini.notify').make_notify()

  -- local global_marks = M.get_global_marks()
  -- local bufname = vim.api.nvim_buf_get_name(0)
  --
  local input = vim.fn.input 'Mark Character: '

  if input == nil then
    return
  end

  if not input:match '%a' then
    vim.notify('A-Z only', vim.log.levels.WARN)
    return
  end

  local mark_char = input:upper()

  vim.cmd('normal! m' .. mark_char)
  vim.notify('Marked ' .. vim.fn.expand '%:t' .. ':' .. vim.api.nvim_win_get_cursor(0)[1] .. ' with ' .. mark_char)
end

M.goto_global_mark = function()
  local global_marks = M.get_global_marks()

  if #global_marks == 0 then
    vim.notify('No global marks set.', vim.log.levels.ERROR)
    return
  end

  vim.cmd 'botright split'
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)

  -- Populate the buffer with global marks
  local lines = {}
  for _, mark in ipairs(global_marks) do
    table.insert(lines, mark.display)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set buffer options
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'

  -- Set keymap for <CR> to navigate to the selected mark
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
    noremap = true,
    silent = true,
    callback = function()
      local line = vim.api.nvim_win_get_cursor(0)[1]
      local choice = global_marks[line]
      if choice and vim.fn.getpos("'" .. choice.mark)[2] > 0 then
        vim.notify(choice)
        vim.cmd("normal! '" .. choice.mark)
        vim.cmd 'close' -- Close the split after navigating
      else
        vim.notify('Invalid mark selected.', vim.log.levels.ERROR)
      end
    end,
  })

  -- vim.ui.select(global_marks, {
  --   prompt = 'Select Mark',
  --   format_item = function(item)
  --     return item.display
  --   end,
  -- }, function(choice)
  --   if choice then
  --     vim.cmd("normal! '" .. choice.mark)
  --   end
  -- end)
end

return M
