---@diagnostic disable: undefined-global
return {
  'folke/snacks.nvim',
  cond = not vim.g.vscode,
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
      '<leader>b',
      function()
        Snacks.picker.buffers { layout = 'select' }
      end,
      desc = 'Buffers',
    },
    {
      '<leader>df',
      function()
        Snacks.picker.diagnostics { layout = 'default' }
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
      '<leader>p',
      function()
        Snacks.picker.smart { hidden = true, preview = false }
      end,
      desc = 'Pick',
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
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches { layout = 'default' }
      end,
      desc = 'Branches',
    },
    -- TODO: keymaps to copy SHA
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log { layout = 'default' }
      end,
      desc = 'Log',
    },
  },
}
