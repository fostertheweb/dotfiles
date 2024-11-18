return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- adapters
    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-vitest',
        require 'neotest-jest',
      },
    }

    vim.keymap.set('n', '<leader>tf', '<CMD>Neotest run file<CR>', { desc = '[T]est [F]ile' })
    vim.keymap.set('n', '<leader>tl', '<CMD>Neotest run last<CR>', { desc = '[T]est [L]ast' })
    vim.keymap.set('n', '<leader>to', '<CMD>Neotest output-panel<CR>', { desc = '[T]est [O]utput' })
    vim.keymap.set('n', '<leader>ts', '<CMD>Neotest output-panel<CR>', { desc = '[T]est [S]ummary' })
  end,
}
