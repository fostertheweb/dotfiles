return {
  'fenetikm/falcon',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'falcon'
    vim.cmd.hi 'Comment gui=none'
  end,
}
