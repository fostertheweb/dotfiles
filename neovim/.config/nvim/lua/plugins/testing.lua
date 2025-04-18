return {
  'nvim-neotest/neotest',
  cond = not vim.g.vscode,
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

    vim.keymap.set('n', '<leader>tf', '<CMD>Neotest run file<CR>', { desc = 'File' })
    vim.keymap.set('n', '<leader>tl', '<CMD>Neotest run last<CR>', { desc = 'Last' })
    vim.keymap.set('n', '<leader>to', '<CMD>Neotest output-panel<CR>', { desc = 'Output' })
    vim.keymap.set('n', '<leader>ts', '<CMD>Neotest summary<CR>', { desc = 'Summary' })
  end,
}
