return {
  {
    'smoka7/hop.nvim',
    enabled = true,
    version = '*',
    config = function()
      require('hop').setup {
        keys = 'etovxqpdygfblzhckisuran',
      }

      vim.keymap.set('n', 'gw', '<CMD>HopWord<CR>', { desc = 'Go to word' })
    end,
  },
  {
    'ghillb/cybu.nvim',
    enabled = false,
    config = function()
      require('cybu').setup {
        display_time = 500,
        behavior = {
          mode = {
            last_used = {
              update_on = 'text_changed',
            },
          },
        },
        style = {
          padding = 2,
          separator = '  ',
          highlights = {
            current_buffer = 'Normal',
            adjacent_buffers = 'Comment',
            background = 'CybuBackground',
            border = 'CybuBorder',
          },
        },
      }

      vim.keymap.set('n', '<C-i>', '<C-i>')
      vim.keymap.set('n', '<S-Tab>', '<CMD>CybuLastusedPrev<CR>')
      vim.keymap.set('n', '<Tab>', '<CMD>CybuLastusedNext<CR>')
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
}
