return {
  {
    'ramilito/winbar.nvim',
    enabled = false,
    event = 'BufReadPre',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('winbar').setup {
        buf_modified = true,
        buf_modified_symbol = '●',
        diagnostics = true,
        dir_levels = 6,
        dim_inactive = {
          enabled = true,
          highlight = 'WinbarNC',
          icons = true,
          name = true,
        },
        icons = true,
      }
    end,
  },
}
