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

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Terminal buffer appearence',
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd 'startinsert'
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
