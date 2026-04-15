vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
}

require('mini.ai').setup {}

require('mini.comment').setup {
  options = {
    ignore_blank_line = true,
    custom_commentstring = function()
      return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
    end,
  },
  mappings = {
    comment = 'g/',
    comment_line = 'g<space>',
    comment_visual = 'g/',
    textobject = 'g/',
  },
}

require('mini.completion').setup {
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = true,
  },
  fallback_action = '<C-x><C-o>',
  mappings = {
    scroll_down = '<C-j>',
    scroll_up = '<C-k>',
  },
}

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

    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

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

    -- Surround
    { mode = 'n', keys = 's' },

    -- U, git commands
    { mode = 'n', keys = 'U' },
    { mode = 'x', keys = 'U' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    { mode = 'n', keys = '<Leader>a', desc = '+AI' },
    { mode = 'n', keys = '<Leader>f', desc = '+Find' },
    { mode = 'n', keys = '<Leader>t', desc = '+Test' },
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    { mode = 'n', keys = '<Leader>j', desc = '+Jump' },
    { mode = { 'n', 'x' }, keys = 'U1', desc = '+Line' },
    { mode = { 'n', 'x' }, keys = 'Uw', desc = '+Web' },
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitive',
  callback = function(args)
    vim.b[args.buf].miniclue_disable = true
  end,
})

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

require('mini.icons').setup {}
require('mini.icons').mock_nvim_web_devicons()

require('mini.pairs').setup()
require('mini.surround').setup()

local MiniVisits = require 'mini.visits'
MiniVisits.setup()

vim.keymap.set('n', 'b', function()
  MiniVisits.add_label 'default'
  vim.notify('Added to visits', vim.log.levels.INFO)
end, { desc = 'Add default label' })

vim.keymap.set('n', 'B', function()
  MiniVisits.remove_label 'default'
  vim.notify('Removed from visits', vim.log.levels.INFO)
end, { desc = 'Remove default label' })

vim.keymap.set('n', '<leader>jj', function()
  MiniVisits.select_path('', { filter = 'default' })
end, { desc = 'Jump to visited' })

vim.keymap.set('n', '<leader>jA', function()
  local label = vim.fn.input 'Label: '
  if label ~= '' then
    MiniVisits.add_label(label)
    vim.notify('Added label: ' .. label, vim.log.levels.INFO)
  end
end, { desc = 'Add custom label' })

local function with_label(prompt, callback)
  local labels = MiniVisits.list_labels()
  if #labels == 0 then
    vim.notify('No existing labels', vim.log.levels.WARN)
    return
  end
  vim.ui.select(labels, { prompt = prompt }, function(label)
    if label then
      callback(label)
    end
  end)
end

vim.keymap.set('n', '<leader>ja', function()
  with_label('Add label:', function(label)
    MiniVisits.add_label(label)
    vim.notify('Added label: ' .. label, vim.log.levels.INFO)
  end)
end, { desc = 'Add existing label' })

vim.keymap.set('n', '<leader>jf', function()
  with_label('Select label:', function(label)
    MiniVisits.select_path('', { filter = label })
  end)
end, { desc = 'List paths for label' })
