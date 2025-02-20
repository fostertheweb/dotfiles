return {
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
    'jinh0/eyeliner.nvim',
    config = function()
      require('eyeliner').setup {
        highlight_on_key = true,
        dim = true,
        disabled_filetypes = {},
        disabled_buftypes = {},
        default_keymaps = true,
      }

      vim.api.nvim_set_hl(0, 'EyelinerPrimary', {
        fg = '#ff007c',
        bold = true,
        ctermfg = 198,
        cterm = { bold = true, underline = true },
      })
      vim.api.nvim_set_hl(0, 'EyelinerSecondary', {
        fg = '#00dfff',
        bold = true,
        ctermfg = 45,
        cterm = { bold = true, underline = true },
      })
    end,
  },
  {
    'leath-dub/snipe.nvim',
    enabled = false,
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
