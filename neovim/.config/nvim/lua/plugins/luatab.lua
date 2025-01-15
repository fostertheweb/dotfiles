return {
  'alvarosevilla95/luatab.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('luatab').setup {}
  end,
}
