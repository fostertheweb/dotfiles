return {
  'cpwrs/americano.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'americano'
    vim.cmd.hi 'Comment gui=none'
  end,
}
