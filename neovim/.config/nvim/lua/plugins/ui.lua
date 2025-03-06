return {
  {
    'b0o/incline.nvim',
    enabled = false,
    config = function()
      require('incline').setup {
        hide = {
          cursorline = false,
          focused_win = true,
          only_win = true,
        },
        window = {
          overlap = {
            borders = true,
            statusline = true,
          },
          placement = {
            horizontal = 'center',
            vertical = 'bottom',
          },
        },
      }
    end,
    event = 'VeryLazy',
  },
  {
    'alvarosevilla95/luatab.nvim',
    enabled = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('luatab').setup {}
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {
        icons = {
          mappings = false,
        },
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        preset = 'helix',
        sort = { 'manual' },
        triggers = {
          { '<auto>', mode = 'nxso' },
          { 's', mode = { 'n', 'x' } },
          { '<C>', mode = { 'n' } },
        },
      }
      require('which-key').add {
        { '<leader>c', group = 'Copilot' },
        { '<leader>d', group = 'Diagnostic' },
        { '<leader>g', group = 'Git' },
        { '<leader>q', group = 'Quickfix' },
        { '<leader>t', group = 'Test' },
      }
    end,
  },
}
