return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.indentscope').setup()
    require('mini.jump').setup()
    -- require('mini.jump2d').setup {
    --   mappings = {
    --     start_jumping = 'gw',
    --   },
    --   view = {
    --     dim = true,
    --   },
    -- }
    require('mini.surround').setup()
  end,
}
