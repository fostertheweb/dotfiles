return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.indentscope').setup {
      draw = {
        animation = function()
          return 0
        end,
      },
      symbol = '│',
    }
    require('mini.surround').setup()
  end,
}
