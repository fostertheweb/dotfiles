-- statusline
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('ActiveStatusline', { clear = true }),
  pattern = '*',
  callback = function()
    vim.wo.statusline = "%!v:lua.require('custom.statusline').statusline()"
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = vim.api.nvim_create_augroup('InactiveStatusline', { clear = true }),
  pattern = '*',
  callback = function()
    local winid = vim.api.nvim_get_current_win()
    vim.wo.statusline = string.format("%%!v:lua.require('custom.statusline').inactive_statusline(%d)", winid)
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
  callback = function()
    vim.cmd 'startinsert'
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Terminal buffer appearence',
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

