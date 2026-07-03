local utils = require 'utils'

local picker_layout = {
  preview = 'main',
  layout = {
    box = 'vertical',
    backdrop = false,
    row = -1,
    width = 0,
    height = 0.4,
    border = 'top',
    title = ' {title} {live} {flags}',
    title_pos = 'left',
    { win = 'input', height = 1, border = 'bottom' },
    {
      box = 'horizontal',
      { win = 'list', border = 'none' },
      { win = 'preview', title = '{preview}', width = 1.0, border = 'none' },
    },
  },
}

vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  bufdelete = {},
  explorer = {
    hidden = true,
  },
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
    hidden = true,
    layout = picker_layout,
    matcher = {
      frecency = true,
    },
    preivew = false,
    ui_select = true,
    formatters = {
      file = {
        filename_first = true,
        truncate = 60,
        icon_width = 3,
      },
    },
    sources = {
      explorer = {
        preview = function()
          return false
        end,
        auto_close = true,
        layout = picker_layout,
      },
      sources = {
        files = { hidden = true },
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

vim.keymap.set('n', '<leader>d', function()
  Snacks.explorer.reveal()
end, { desc = 'Directory' })

vim.keymap.set('n', '<leader>/', function()
  Snacks.picker.lines()
end, { desc = 'Grep' })

vim.keymap.set('n', '<leader>fg', function()
  Snacks.picker.grep { hidden = true, ignored = false }
end, { desc = 'Grep' })

vim.keymap.set('n', '<leader><leader>', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })

vim.keymap.set('n', '<leader>fs', function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = 'Workspace Symbols' })

vim.keymap.set('n', '<leader>fo', function()
  Snacks.picker.lsp_symbols()
end, { desc = 'Document Symbols' })

vim.keymap.set('n', '<leader>fr', function()
  Snacks.picker.lsp_references()
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
  Snacks.picker.smart {
    multi = { 'buffers', 'files' },
    hidden = true,
  }
end, { desc = 'Files' })

vim.keymap.set('n', '<leader>gs', function()
  Snacks.picker.git_status()
end, { desc = 'Status' })

vim.keymap.set('n', '<leader>gd', function()
  Snacks.picker.git_diff {
    group = true,
    base = 'origin/head',
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
