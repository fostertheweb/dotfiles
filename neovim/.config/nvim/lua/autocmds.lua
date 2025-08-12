-- statusline
vim.api.nvim_create_autocmd({
  'ColorScheme',
  'VimEnter',
  'WinEnter',
  'WinClosed',
  'BufEnter',
  'BufWritePost',
  'TermOpen',
  'TermClose',
  'TextChanged',
  'TextChangedI',
}, {
  group = vim.api.nvim_create_augroup('ActiveStatusline', { clear = true }),
  pattern = '*',
  callback = function()
    local win = vim.api.nvim_get_current_win()
    local cfg = vim.api.nvim_win_get_config(win)

    if cfg.relative ~= '' or (vim.bo.buftype == 'terminal' and vim.fn.winnr '$' == 1) then
      return
    end

    vim.o.statusline = require('custom.statusline').statusline()
    vim.o.laststatus = 3
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Terminal buffer appearence',
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    if vim.fn.winnr '$' == 1 then
      vim.o.laststatus = 0
    end
    vim.cmd 'startinsert'
  end,
})

vim.api.nvim_create_autocmd({ 'WinNew', 'WinClosed', 'BufWinEnter' }, {
  desc = 'Toggle statusbar for terminal buffers based on split count',
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      if vim.fn.winnr '$' == 1 then
        vim.o.laststatus = 0
      else
        vim.o.laststatus = 3
      end
    end
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  callback = function()
    vim.schedule(function()
      if vim.bo.buftype == 'terminal' and vim.v.shell_error == 0 then
        vim.cmd('bdelete! ' .. vim.fn.expand '<abuf>')
      end
    end)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start commit editor in insert mode',
  pattern = 'gitcommit',
  command = 'startinsert',
})
