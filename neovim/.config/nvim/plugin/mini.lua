vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

require('mini.comment').setup {
  options = {
    ignore_blank_line = true,
    -- custom_commentstring = function()
      -- return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
    -- end,
  },
  mappings = {
    comment = 'g/',
    comment_line = 'g<space>',
    comment_visual = 'g/',
    textobject = 'g/',
  },
}

require('mini.completion').setup {}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'snacks_input', 'snacks_picker_input' },
  callback = function(args)
    vim.b[args.buf].minicompletion_disable = true
  end,
})

-- Tab to accept completion
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<Tab>'
end, { expr = true, noremap = true })

local miniclue = require 'mini.clue'
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    { mode = 'n', keys = '<Leader>f', desc = '+Find' },
    { mode = 'n', keys = '<Leader>t', desc = '+Test' },
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },

  window = {
    config = {
      width = 'auto',
    },
    delay = 500,
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
}

local MiniDiff = require 'mini.diff'
MiniDiff.setup {
  mappings = {
    apply = '',
    reset = '',
    textobject = '',
  },
}

vim.keymap.set('n', '<leader>gD', MiniDiff.toggle_overlay, { desc = 'Diff overlay' })

vim.api.nvim_create_user_command('DiffOriginMain', function()
  MiniDiff.setup {
    source = {
      attach = function(buf_id)
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf_id), ':.')
        local ref = vim.fn.system { 'git', 'show', 'origin/main:' .. path }
        if vim.v.shell_error == 0 then
          MiniDiff.set_ref_text(buf_id, ref)
        else
          return false
        end
      end,
    },
  }
end, {})

require('mini.files').setup {
  mappings = {
    go_in = '',
    go_in_plus = 'l',
  },
  windows = {
    preview = false,
    max_number = 2,
    width_focus = 30,
    width_nofocus = 30,
    width_preview = 80,
  },
}

vim.keymap.set('n', '-', function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
  require('mini.files').open(path)
end, { desc = 'Open file explorer' })

require('mini.icons').setup {}
require('mini.icons').mock_nvim_web_devicons()

require('mini.notify').setup {
  window = {
    config = { anchor = 'NE', col = vim.o.columns, row = 0 },
  },
}

require('mini.surround').setup()
