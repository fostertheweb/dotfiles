return {
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
