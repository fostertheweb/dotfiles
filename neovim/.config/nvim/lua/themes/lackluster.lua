return {
  'slugbyte/lackluster.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'lackluster-hack'
    vim.cmd.hi 'Comment gui=none'
  end,
}
