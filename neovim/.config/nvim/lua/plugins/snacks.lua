---@diagnostic disable: undefined-global
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
      layout = {
        preset = 'vscode',
      },
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
      '<leader>p',
      function()
        Snacks.picker.files { hidden = true, preview = false }
      end,
      desc = 'Files',
    },
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
      '<leader>df',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Find',
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
        Snacks.picker.help { layout = 'default' }
      end,
      desc = 'Help',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.smart { preview = false }
      end,
      desc = 'Find',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.lsp_symbols { preview = false }
      end,
      desc = 'Symbols',
    },
    {
      '<leader>.',
      function()
        Snacks.picker.recent() { preview = false }
      end,
      desc = 'Recent Files',
    },
  },
}
