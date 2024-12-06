return {
  'ribru17/bamboo.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'bamboo'
    vim.cmd.hi 'Comment gui=none'

    require('bamboo').setup {
      style = 'multiplex',
    }
    require('bamboo').load()
  end,
}
