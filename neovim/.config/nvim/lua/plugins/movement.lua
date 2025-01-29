return {
  {
    'mawkler/demicolon.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {},
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    config = function()
      require('hop').setup {
        keys = 'etovxqpdygfblzhckisuran',
      }

      vim.keymap.set('n', 'gw', '<CMD>HopWord<CR>', { desc = 'Go to word' })
    end,
  },
  {
    'leath-dub/snipe.nvim',
    config = function()
      -- TODO: ctrl-j to accept, q close, ctrl-c close, ctrl-k to close buffer
      require('snipe').setup {
        ui = {
          position = 'center',
          open_win_override = {
            title = 'Buffers',
            border = 'single',
          },
        },
      }

      vim.keymap.set('n', 'gj', function()
        require('snipe').open_buffer_menu()
      end, { desc = 'Jump to buffer' })
    end,
  },
}
