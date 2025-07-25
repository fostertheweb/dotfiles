return {
  {
    'otavioschwanck/arrow.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      show_icons = true,
      leader_key = ',',
      buffer_leader_key = 'm',
    },
  },
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
