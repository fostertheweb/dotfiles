return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup {
      terminalColors = true,
      dimInactive = true,
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
        return {
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          NormalFloat = {
            bg = colors.palette.dragonBlack3,
          },
          Term = {
            bg = colors.palette.dragonBlack3,
          },
        }
      end,
    }

    vim.opt.termguicolors = true
    vim.cmd.colorscheme 'kanagawa-dragon'
    vim.cmd.hi 'Comment gui=none'
  end,
}
