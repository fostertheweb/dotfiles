return {
  'Shatur/neovim-ayu',
  lazy = false,
  priority = 1000,
  config = function()
    local colors = require 'ayu.colors'
    colors.generate()

    require('ayu').setup {
      mirage = false,
      terminal = true,
      overrides = function()
        return { Comment = { fg = colors.comment } }
      end,
    }

    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'ayu'
    vim.cmd.hi 'Comment gui=none'
  end,
}
