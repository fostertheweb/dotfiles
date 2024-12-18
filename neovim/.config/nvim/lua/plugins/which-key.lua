return {
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
      },
    }
    require('which-key').add {
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>gh', group = 'Hunk' },
      { '<leader>gw', group = 'Web' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Diagnostic' },
      { '<leader>q', group = 'Quickfix' },
      { '<leader>t', group = 'Test' },
      { '<leader>h', group = 'Help' },
    }
  end,
}
