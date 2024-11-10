return {
  'savq/melange-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'melange'
    vim.cmd.hi 'Comment gui=none'
  end,
}
