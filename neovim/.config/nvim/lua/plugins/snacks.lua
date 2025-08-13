---@diagnostic disable: undefined-global

local mini_layout = {
  preview = false,
  layout = {
    backdrop = false,
    border = 'single',
    box = 'vertical',
    col = 0,
    row = -2,
    height = 0.4,
    width = 0.5,
    title = '{title}',
    title_pos = 'left',
    { win = 'input', height = 1, border = 'none' },
    { win = 'list', border = 'none' },
  },
}

return {
  'folke/snacks.nvim',
  opts = {
    bufdelete = {},
    indent = {
      only_scope = true,
      only_current = true,
      chunk = {
        enabled = true,
        only_current = true,
      },
    },
    input = {},
    layout = {},
    picker = {
      layout = mini_layout,
      matcher = {
        frecency = true,
      },
      ui_select = true,
      formatters = {
        file = {
          filename_first = true,
          icon_width = 3,
        },
      },
      terminal = {},
      win = {
        input = {
          keys = {
            ['<C-j>'] = { 'confirm', mode = { 'n', 'i' } },
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader>/',
      function()
        Snacks.picker.grep { hidden = true, ignored = false, layout = 'default' }
      end,
      desc = 'Search',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers { layout = 'select' }
      end,
      desc = 'Buffers',
    },
    {
      '<leader>k',
      function()
        Snacks.picker.diagnostics { layout = 'ivy', preview = false }
      end,
      desc = 'Problems',
    },
    {
      '<leader>u',
      function()
        Snacks.picker.undo { layout = 'default' }
      end,
      desc = 'Undo',
    },
    {
      '<leader>h',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help',
    },
    {
      '<leader>p',
      function()
        Snacks.picker.smart { hidden = true }
      end,
      desc = 'Pick',
    },
    {
      '<leader>.',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent Files',
    },
    {
      '<C-Space>',
      function()
        Snacks.terminal.toggle('opencode', {
          float = true,
          win = {
            width = 0.5,
            height = 0.99,
            border = 'left',
            row = 0,
            col = 0.5,
          },
        })
      end,
      mode = { 't', 'n', 'x', 'v' },
    },
    {
      '<C-g>',
      function()
        Snacks.terminal.toggle('gitu', {
          win = {
            width = vim.o.columns,
            height = vim.o.lines,
            border = 'none',
            row = 0,
            col = 0,
          },
        })
      end,
      mode = 'n',
    },
  },
}
