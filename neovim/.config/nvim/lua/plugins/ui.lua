local utils = require 'utils'

return {
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        float = {
          max_height = 20,
          override = function(defaults)
            defaults['col'] = 0
            defaults['row'] = 0
            defaults['width'] = 40
            return defaults
          end,
        },
        keymaps = {
          ['<C-j>'] = 'actions.select',
          ['l'] = 'actions.select',
          ['q'] = { 'actions.close', mode = 'n' },
          ['<Esc>'] = { 'actions.close', mode = 'n' },
        },
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
      }

      vim.keymap.set('n', '-', require('oil').open_float, { desc = 'Open parent directory' })
    end,
    dependencies = {
      { 'echasnovski/mini.icons', opts = {}, 'benomahony/oil-git.nvim' },
    },
    lazy = false,
  },
  {
    'b0o/incline.nvim',
    enabled = true,
    cond = not vim.g.vscode,
    config = function()
      local devicons = require 'nvim-web-devicons'

      require('incline').setup {
        hide = {
          cursorline = false,
          focused_win = true,
          only_win = true,
        },
        window = {
          padding = 0,
          margin = {
            horizontal = 0,
            vertical = 0,
          },
          overlap = {
            borders = false,
            statusline = true,
            tabline = false,
            winbar = false,
          },
          placement = {
            horizontal = 'left',
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
          }
        end,
      }
    end,
    event = 'VeryLazy',
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
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
        preset = 'classic',
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
