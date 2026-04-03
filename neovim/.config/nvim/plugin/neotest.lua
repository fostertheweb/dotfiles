vim.pack.add {
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/antoinemadec/FixCursorHold.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  -- adapters
  'https://github.com/marilari88/neotest-vitest',
  'https://github.com/nvim-neotest/neotest-jest',
  'https://github.com/fredrikaverpil/neotest-golang',
}

require('neotest').setup {
  adapters = {
    require 'neotest-vitest',
    require 'neotest-jest',
    require 'neotest-golang',
  },
}

vim.keymap.set('n', '<leader>tf', '<CMD>Neotest run file<CR>', { desc = 'File' })
vim.keymap.set('n', '<leader>tl', '<CMD>Neotest run last<CR>', { desc = 'Last' })
vim.keymap.set('n', '<leader>to', '<CMD>Neotest output-panel<CR>', { desc = 'Output' })
vim.keymap.set('n', '<leader>ts', '<CMD>Neotest summary<CR>', { desc = 'Summary' })
