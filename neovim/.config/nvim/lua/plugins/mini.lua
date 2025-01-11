return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.indentscope').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
  end,
}
