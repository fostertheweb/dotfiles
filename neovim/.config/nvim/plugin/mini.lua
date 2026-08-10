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
end, { expr = true, noremap = true, desc = 'Accept completion' })

require('mini.icons').setup {}
require('mini.icons').mock_nvim_web_devicons()

require('mini.pairs').setup()
require('mini.surround').setup()
