return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup {
      icons = {
        mappings = false,
      },
      preset = 'helix',
      sort = { 'manual' },
      triggers = {
        { '<leader>', mode = { 'n', 'v' } },
        { 's', mode = { 'n', 'x' } },
        { 'g', mode = { 'n', 'v' } },
      },
    }
    require('which-key').add {
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Diagnostic' },
      { '<leader>gh', group = 'Hunk' },
      { '<leader>t', group = 'Test' },
      { '<leader>h', group = 'Help' },
    }
  end,
}
