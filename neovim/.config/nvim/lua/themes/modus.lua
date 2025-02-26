return {
  'miikanissi/modus-themes.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('modus-themes').setup {
      style = 'auto',
      variant = 'tinted',
    }
  end,
}
