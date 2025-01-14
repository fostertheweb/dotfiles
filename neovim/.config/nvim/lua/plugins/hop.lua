return {
  'smoka7/hop.nvim',
  version = '*',
  config = function()
    require('hop').setup {
      keys = 'etovxqpdygfblzhckisuran',
    }

    vim.keymap.set('n', 'gw', '<CMD>HopWord<CR>', { desc = 'Go to word' })
  end,
}
