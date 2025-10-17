return {
  {
    'ahkohd/buffer-sticks.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>j',
        function()
          require('buffer-sticks').jump()
        end,
        desc = 'Jump to buffer',
      },
    },
    config = function()
      local sticks = require 'buffer-sticks'
      sticks.setup {
        transparent = true,
        filter = { buftypes = { 'terminal' } },
        highlights = {
          active = { link = 'Statement' },
          inactive = { link = 'Whitespace' },
          active_modified = { link = 'Constant' },
          inactive_modified = { link = 'Constant' },
          label = { link = 'Comment' },
        },
      }
      sticks.show()
    end,
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    config = function()
      require('quicker').setup {
        opts = {
          buflisted = false,
          number = false,
          relativenumber = false,
          signcolumn = 'auto',
          winfixheight = true,
          wrap = false,
        },
        borders = {
          vert = '|',
        },
        keys = {
          { '<C-j>', '<CR>', desc = 'Ctrl-j to accept' },
        },
        trim_leading_whitespace = 'all',
      }
    end,
  },
}
