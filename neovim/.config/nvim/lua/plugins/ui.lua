local utils = require 'utils'

return {
  {
    'utilyre/barbecue.nvim',
    enabled = false,
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('barbecue').setup {
        attach_navic = false,
        create_autocmd = false,
        show_modified = true,
        show_navic = false,
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
    'b0o/incline.nvim',
    enabled = false,
    config = function()
      local devicons = require 'nvim-web-devicons'

      require('incline').setup {
        hide = {
          cursorline = 'focused_win',
          focused_win = false,
          only_win = false,
        },
        window = {
          padding = 0,
          margin = {
            horizontal = 0,
            vertical = 0,
          },
          overlap = {
            borders = true,
            statusline = false,
            tabline = false,
            winbar = false,
          },
          placement = {
            horizontal = 'right',
            vertical = 'top',
          },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')

          if filename == '' then
            filename = ' [No Name]'
          end

          local modified = vim.bo[props.buf].modified
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified_fg = utils.get_colors('DiagnosticWarn').guifg

          return {
            modified and { ' ●  ', guifg = modified_fg } or ft_icon and { ' ', ft_icon, '  ', guifg = ft_color } or '',
            {
              filename,
              gui = modified and 'bold,italic' or 'bold',
              guifg = modified and modified_fg or utils.get_colors('Normal').guifg,
            },
            ' ',
            guibg = utils.get_colors('FloatShadow').guibg,
          }
        end,
      }
    end,
    event = 'VeryLazy',
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
          lualine_b = { 'diagnostics' },
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
        defer = function(ctx)
          if vim.list_contains({ 'd', 'y' }, ctx.operator) then
            return true
          end
          return vim.list_contains({ '<C-V>', 'V' }, ctx.mode)
        end,
      }
      require('which-key').add {
        { '<leader>c', group = 'Copilot' },
        { '<leader>d', group = 'Diagnostic' },
        { '<leader>g', group = 'Git' },
        { '<leader>q', group = 'Quickfix' },
        { '<leader>t', group = 'Test' },
      }
    end,
  },
}
