vim.keymap.set('n', '<leader>fd', function()
  vim.diagnostic.setqflist()
  vim.cmd 'copen'
end, { desc = 'Diagnostics', silent = true })
