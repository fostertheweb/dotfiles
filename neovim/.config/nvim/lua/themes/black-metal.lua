return {
  'metalelf0/base16-black-metal-scheme',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'base16-black-metal'
    vim.cmd.hi 'Comment gui=none'
  end,
}
