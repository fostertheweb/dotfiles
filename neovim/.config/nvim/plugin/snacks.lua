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
    width = 0.6,
    title = '{title}',
    title_pos = 'left',
    { win = 'input', height = 1, border = 'none' },
    { win = 'list', border = 'none' },
  },
}

vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  bufdelete = {},
  gh = {},
  image = {},
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
    previewers = {
      diff = {
        style = 'syntax',
      },
    },
  },
  terminal = {},
  win = {},
  styles = {
    input = {
      relative = 'cursor',
      row = -3,
      col = 0,
    },
  },
}

vim.keymap.set('n', '<leader>/', function()
  Snacks.picker.grep { hidden = true, ignored = false, layout = 'default' }
end, { desc = 'Search' })

vim.keymap.set('n', '<leader><leader>', function()
  Snacks.picker.buffers { layout = 'select' }
end, { desc = 'Buffers' })

vim.keymap.set('n', '<leader>fs', function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = 'Workspace Symbols' })

vim.keymap.set('n', '<leader>fo', function()
  Snacks.picker.lsp_symbols()
end, { desc = 'Document Symbols' })

vim.keymap.set('n', '<leader>fr', function()
  Snacks.picker.lsp_references { layout = 'default' }
end, { desc = 'References' })

vim.keymap.set({ 'n', 'x' }, '<leader>fw', function()
  Snacks.picker.grep_word { hidden = true, ignored = false }
end, { desc = 'Word' })

vim.keymap.set('n', '<leader>f<leader>', function()
  Snacks.picker.resume()
end, { desc = 'Resume' })

vim.keymap.set('n', '<leader>k', function()
  Snacks.picker.diagnostics()
end, { desc = 'Problems' })

vim.keymap.set('n', '<leader>h', function()
  Snacks.picker.help()
end, { desc = 'Help' })

vim.keymap.set('n', '<leader>p', function()
  Snacks.picker.smart { hidden = true }
end, { desc = 'Files' })

vim.keymap.set('n', '<leader>gs', function()
  Snacks.picker.git_status {
    layout = 'default',
  }
end, { desc = 'Status' })

vim.keymap.set('n', '<leader>gd', function()
  Snacks.picker.git_diff {
    group = true,
    base = 'origin/head',
    layout = 'default',
  }
end, { desc = 'Changes' })

vim.keymap.set('n', '<leader>fq', function()
  Snacks.picker.qflist()
end, { desc = 'Quickfix' })

vim.keymap.set('n', '<leader>f.', function()
  Snacks.picker.recent()
end, { desc = 'Recent Files' })

vim.keymap.set('n', '<leader><BS>', function()
  Snacks.bufdelete()
end, { desc = 'Delete buffer' })

vim.keymap.set('n', '<leader>gw', utils.open_pr_diff, { desc = 'GitHub PR Diff' })
