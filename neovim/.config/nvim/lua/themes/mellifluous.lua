return {
  'ramojus/mellifluous.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'mellifluous'
    vim.cmd.hi 'Comment gui=none'
  end,
}
