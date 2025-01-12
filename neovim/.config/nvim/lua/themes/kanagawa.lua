return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup {
      terminalColors = true,
      dimInactive = true,
      background = {
        dark = 'dragon',
        light = 'wave',
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
              bg_term = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
    }

    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'kanagawa-dragon'
    vim.cmd.hi 'Comment gui=none'
  end,
}
