return {
  'echasnovski/mini.nvim',
  config = function()
    -- TODO: try pairs, clue
    require('mini.ai').setup { n_lines = 500 }
    require('mini.indentscope').setup()
    require('mini.surround').setup()
  end,
}
