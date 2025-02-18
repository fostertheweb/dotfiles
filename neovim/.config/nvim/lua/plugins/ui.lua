return {
  {
    'utilyre/barbecue.nvim',
    enabled = true,
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('barbecue').setup {
        create_autocmd = false,
        show_modified = true,
      }

      vim.api.nvim_create_autocmd({
        'WinResized',
        'BufWinEnter',
        'CursorHold',
        'InsertLeave',
        'BufModifiedSet',
      }, {
        group = vim.api.nvim_create_augroup('barbecue.updater', {}),
        callback = function()
          require('barbecue.ui').update()
        end,
      })
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {
      input = {
        border = 'single',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = '',
          section_separators = '',
        },
        sections = {
          lualine_a = {
            {
              'mode',
            },
          },
          lualine_b = { 'filename' },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { 'branch', 'diff' },
          lualine_z = {},
        },
      }
    end,
  },
  {
    'alvarosevilla95/luatab.nvim',
    enabled = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('luatab').setup {}
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
          { 's', mode = { 'n', 'x' } },
          { '<C>', mode = { 'n' } },
        },
      }
      require('which-key').add {
        { '<leader>c', group = 'Copilot' },
        { '<leader>d', group = 'Diagnostic' },
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>q', group = 'Quickfix' },
        { '<leader>t', group = 'Test' },
        { '<leader>h', group = 'Help' },
      }
    end,
  },
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
