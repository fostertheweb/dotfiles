return {
  {
    'ahkohd/buffer-sticks.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>j',
        function()
          require('buffer-sticks').jump()
        end,
        desc = 'Jump to buffer',
      },
    },
    config = function()
      local sticks = require 'buffer-sticks'
      sticks.setup {
        transparent = true,
        filter = { buftypes = { 'terminal' } },
        highlights = {
          active = { link = 'Statement' },
          inactive = { link = 'Whitespace' },
          active_modified = { link = 'Constant' },
          inactive_modified = { link = 'Constant' },
          label = { link = 'Comment' },
        },
      }
      sticks.show()
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local custom_theme = {
        normal = {
          a = { bg = 'NONE' },
          b = { bg = 'NONE' },
          c = { bg = 'NONE' },
          x = { bg = 'NONE' },
          y = { bg = 'NONE' },
          z = { bg = 'NONE' },
        },
        insert = {
          a = { bg = 'NONE' },
          b = { bg = 'NONE' },
          c = { bg = 'NONE' },
          x = { bg = 'NONE' },
          y = { bg = 'NONE' },
          z = { bg = 'NONE' },
        },
        visual = {
          a = { bg = 'NONE' },
          b = { bg = 'NONE' },
          c = { bg = 'NONE' },
          x = { bg = 'NONE' },
          y = { bg = 'NONE' },
          z = { bg = 'NONE' },
        },
        replace = {
          a = { bg = 'NONE' },
          b = { bg = 'NONE' },
          c = { bg = 'NONE' },
          x = { bg = 'NONE' },
          y = { bg = 'NONE' },
          z = { bg = 'NONE' },
        },
        command = {
          a = { bg = 'NONE' },
          b = { bg = 'NONE' },
          c = { bg = 'NONE' },
          x = { bg = 'NONE' },
          y = { bg = 'NONE' },
          z = { bg = 'NONE' },
        },
        inactive = {
          a = { bg = 'NONE' },
          b = { bg = 'NONE' },
          c = { bg = 'NONE' },
          x = { bg = 'NONE' },
          y = { bg = 'NONE' },
          z = { bg = 'NONE' },
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
          always_divide_middle = false,
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
              'navic',
              separator = '',
              padding = { left = 1, right = 0 },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            {
              'diagnostics',
              sections = { 'error', 'warn' },
            },
            {
              'branch',
              color = 'Comment',
              icon = '',
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
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  {
    'SmiteshP/nvim-navic',
    config = function()
      require('nvim-navic').setup {
        click = true,
        highlight = true,
        separator = ' ➜ ',
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
    enabled = false,
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
      }
    end,
  },
}
