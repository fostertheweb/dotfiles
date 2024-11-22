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
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]iagnostic' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>g', group = '[G]it' },
      { '<leader>gh', group = '[H]unk' },
      { '<leader>t', group = '[T]est' },
    }
  end,
}
