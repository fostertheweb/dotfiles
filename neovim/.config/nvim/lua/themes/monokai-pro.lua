return {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('monokai-pro').setup {
      filter = 'light',
      overridePalette = function()
        return {
          dark2 = '#d2c9c4',
          dark1 = '#eee5de',
          background = '#f8efe7',
          text = '#2c232e',
          accent1 = '#ce4770',
          accent2 = '#d4572b',
          accent3 = '#b16803',
          accent4 = '#218871',
          accent5 = '#2473b6',
          accent6 = '#6851a2',
          dimmed1 = '#72696d',
          dimmed2 = '#92898a',
          dimmed3 = '#a59c9c',
          dimmed4 = '#beb5b3',
          dimmed5 = '#d2c9c4',
        }
      end,
    }
  end,
}
