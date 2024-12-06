return {
  'jacoborus/tender.vim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'tender'
    vim.cmd.hi 'Comment gui=none'
  end,
}
