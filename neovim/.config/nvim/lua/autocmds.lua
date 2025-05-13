-- statusline
if not vim.g.vscode then
  vim.api.nvim_create_autocmd({ 'ColorScheme', 'VimEnter', 'WinEnter', 'BufEnter', 'BufWritePost', 'TextChanged', 'TextChangedI' }, {
    group = vim.api.nvim_create_augroup('ActiveStatusline', { clear = true }),
    pattern = '*',
    callback = function()
      local win = vim.api.nvim_get_current_win()
      local cfg = vim.api.nvim_win_get_config(win)

      if cfg.relative ~= '' then
        return
      end

      vim.o.statusline = require('custom.statusline').statusline()
    end,
  })
end

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

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Start terminal buffer in insert mode',
  pattern = 'term://*',
  command = 'startinsert',
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Terminal buffer appearence',
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ 'BufHidden', 'TermClose' }, {
  pattern = 'term://*',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]:match 'Process exited' then
      vim.cmd 'silent! bd!'
    end
  end,
})
