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
    }
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>g', group = '[G]it' },
    }
  end,
}
