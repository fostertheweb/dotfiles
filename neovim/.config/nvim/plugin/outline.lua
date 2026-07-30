vim.pack.add { 'https://github.com/hedyhli/outline.nvim' }

require('outline').setup()

vim.keymap.set('n', '<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
