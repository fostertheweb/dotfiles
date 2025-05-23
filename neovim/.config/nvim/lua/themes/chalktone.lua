return {
  'daneofmanythings/chalktone.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('chalktone').setup {
      theme = 'default',
      formatting = {
        builtin_strings = {
          styling = { italic = false },
        },
      },
    }
  end,
}
