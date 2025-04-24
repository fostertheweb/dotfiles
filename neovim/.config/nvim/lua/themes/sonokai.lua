return {
  'sainnhe/sonokai',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.sonokai_enable_italic = false
    vim.g.sonokai_style = 'shusia'
    -- vim.cmd.colorscheme 'sonokai'
  end,
}
