return {
  'oonamo/ef-themes.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('ef-themes').setup {
      modules = {
        fzf = true,
        mini = true,
        treesitter = true,
      },
    }
  end,
}
