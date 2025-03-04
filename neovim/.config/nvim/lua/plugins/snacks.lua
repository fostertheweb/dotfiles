---@diagnostic disable: undefined-global
return {
  'folke/snacks.nvim',
  opts = {
    bufdelete = {},
    dim = {},
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
      preview = false,
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
        Snacks.picker.files { hidden = true }
      end,
      desc = 'Files',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.grep { hidden = true, ignored = false }
      end,
      desc = 'Grep',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers()
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
        Snacks.picker.undo()
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
      '<leader>/',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Find',
    },
  },
}
