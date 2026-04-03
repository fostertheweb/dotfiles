vim.pack.add { 'https://github.com/smoka7/hop.nvim' }

require('hop').setup {
  keys = 'etovxqpdygfblzhckisuran',
}

vim.keymap.set('n', 'gw', '<CMD>HopWord<CR>', { desc = 'Go to word' })
