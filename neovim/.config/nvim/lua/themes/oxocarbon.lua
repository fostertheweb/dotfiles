return {
  'nyoom-engineering/oxocarbon.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'oxocarbon'
    vim.cmd.hi 'Comment gui=none'
  end,
}
