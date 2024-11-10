return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'gruvbox'
    vim.cmd.hi 'Comment gui=none'
  end,
}
