vim.pack.add {
  'https://github.com/tpope/vim-fugitive',
}

vim.keymap.set('n', '<C-g>', '<CMD>Git<CR>', { desc = 'Stage' })
vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = 'Commit' })
vim.keymap.set('n', '<leader>gb', '<CMD>Git blame<CR>', { desc = 'Blame' })
