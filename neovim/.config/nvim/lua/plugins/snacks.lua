---@diagnostic disable: undefined-global

local utils = require 'utils'

local mini_layout = {
  preview = 'main',
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
    gh = {},
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
          truncate = 60,
          icon_width = 3,
        },
      },
      actions = {
        cursor_start = utils.move_to_start_of_line,
        cursor_end = utils.move_to_end_of_line,
        kill_line = utils.cut,
      },
      win = {
        input = {
          keys = {
            ['<C-j>'] = { 'confirm', mode = { 'n', 'i' } },
            ['<C-a>'] = { 'cursor_start', mode = { 'i' } },
            ['<C-e>'] = { 'cursor_end', mode = { 'i' } },
            ['<C-k>'] = { 'kill_line', mode = { 'i' } },
          },
        },
      },
    },
    terminal = {},
    win = {},
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
      '<leader>fs',
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = 'Workspace Symbols',
    },
    {
      '<leader>fo',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = 'Document Symbols',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.lsp_references { layout = 'default' }
      end,
      desc = 'References',
    },
    {
      '<leader>k',
      function()
        Snacks.picker.diagnostics()
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
      desc = 'Files',
    },
    {
      '<leader>gg',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Changes',
    },
    {
      '<leader>gr',
      function()
        Snacks.picker.git_diff { base = 'origin/HEAD' }
      end,
      desc = 'Review diff',
    },
    {
      '<leader>fq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix',
    },
    {
      '<leader>.',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent Files',
    },
    {
      '<C-g>',
      function()
        Snacks.terminal.toggle('git add -i', {
          win = {
            width = vim.o.columns,
            height = vim.o.lines - 1,
            border = 'none',
            row = 0,
            col = 0,
          },
        })
      end,
      mode = { 'n', 't' },
    },
    {
      '<leader><BS>',
      function()
        if #vim.api.nvim_list_tabpages() > 1 then
          vim.cmd 'tabclose'
        else
          Snacks.bufdelete()
        end
      end,
      mode = 'n',
      desc = 'Close tab or delete',
    },
  },
}
