local utils = require 'utils'

return {
  {
    'eduardo-antunes/plainline',
    enabled = false,
    config = function()
      require('plainline').setup 'emacs'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local custom_theme = {
        normal = {
          a = { bg = utils.get_colors('Normal').bg },
          z = { bg = utils.get_colors('Normal').bg },
        },
        insert = {
          a = { bg = utils.get_colors('Normal').bg },
          z = { bg = utils.get_colors('Normal').bg },
        },
        visual = {
          a = { bg = utils.get_colors('Normal').bg },
          z = { bg = utils.get_colors('Normal').bg },
        },
        replace = {
          a = { bg = utils.get_colors('Normal').bg },
          z = { bg = utils.get_colors('Normal').bg },
        },
        command = {
          a = { bg = utils.get_colors('Normal').bg },
          z = { bg = utils.get_colors('Normal').bg },
        },
        inactive = {
          a = { bg = utils.get_colors('Normal').bg },
          z = { bg = utils.get_colors('Normal').bg },
        },
      }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = custom_theme,
          component_separators = { left = ' ', right = ' ' },

          section_separators = { left = ' ', right = ' ' },
          disabled_filetypes = {
            quickfix = {},
            statusline = {},
            terminmal = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
              'WinEnter',
              'BufEnter',
              'BufWritePost',
              'SessionLoadPost',
              'FileChangedShellPost',
              'VimResized',
              'Filetype',
              'CursorMoved',
              'CursorMovedI',
            },
          },
        },
        sections = {
          lualine_a = {
            {
              "require'custom.statusline'.file_path_component()",
              serperator = '',
              padding = { left = 1, right = 0 },
            },
            {
              "require'custom.statusline'.file_name_component()",
              padding = { left = 0, right = 0 },
              serperator = '',
            },
            {
              'diagnostics',
              sections = { 'error', 'warn' },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              'branch',
              icon = ' ',
              separator = '',
            },
            {
              'diff',
              diff_color = {
                added = 'DiagnosticOk',
                modified = 'MiniIconsOrange',
                removed = 'DiagnosticError',
              },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    config = function()
      require('quicker').setup {
        opts = {
          buflisted = false,
          number = false,
          relativenumber = false,
          signcolumn = 'auto',
          winfixheight = true,
          wrap = false,
        },
        borders = {
          vert = '|',
        },
        keys = {
          { '<C-j>', '<CR>', desc = 'Ctrl-j to accept' },
        },
        trim_leading_whitespace = 'all',
      }
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {
        icons = {
          mappings = false,
        },
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        preset = 'helix',
        sort = { 'manual' },
        triggers = {
          { '<auto>', mode = 'nxso' },
          { 's', mode = { 'n', 'x', 'v' } },
          { '<C>', mode = { 'n', 'i', 'v', 'x' } },
        },
        win = { border = 'single' },
        defer = function(ctx)
          if vim.list_contains({ 'd', 'y' }, ctx.operator) then
            return true
          end
          return vim.list_contains({ '<C-V>', 'V' }, ctx.mode)
        end,
      }
      require('which-key').add {
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>o', group = 'opencode' },
        { '<leader>q', group = 'Quickfix' },
        { '<leader>t', group = 'Test' },
        { '<leader>0', hidden = true },
        { '<leader>1', hidden = true },
        { '<leader>2', hidden = true },
        { '<leader>3', hidden = true },
        { '<leader>4', hidden = true },
        { '<leader>5', hidden = true },
        { '<leader>6', hidden = true },
        { '<leader>7', hidden = true },
        { '<leader>8', hidden = true },
        { '<leader>9', hidden = true },
      }
    end,
  },
}
