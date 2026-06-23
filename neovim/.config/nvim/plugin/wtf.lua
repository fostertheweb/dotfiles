local utils = require 'utils'

vim.pack.add {
  'https://github.com/fostertheweb/wtf.nvim',
}

require('wtf').setup {
  popup_type = 'popup',
  provider = utils.is_work_computer() and 'openai' or 'opencode-go',
  providers = {
    ['opencode-go'] = {
      model_id = 'deepseek-v4-flash',
    },
  },
  hooks = {
    request_started = function()
      vim.cmd 'hi StatusLine ctermbg=NONE ctermfg=yellow'
    end,
    request_finished = function()
      vim.cmd 'hi StatusLine ctermbg=NONE ctermfg=NONE'
    end,
  },
}

vim.keymap.set('n', '<leader>af', function()
  require('wtf').fix()
end, { desc = 'Fix' })

vim.keymap.set({ 'n', 'x' }, '<leader>ae', function()
  require('wtf').explain()
end, { desc = 'Explain' })

vim.keymap.set('n', '<leader>ad', function()
  require('wtf').diagnose()
end, { desc = 'Diagnose' })

vim.keymap.set('n', '<leader>as', function()
  require('wtf').search()
end, { desc = 'Search' })

vim.keymap.set('n', '<leader>ah', function()
  require('wtf').history()
end, { desc = 'History' })

vim.keymap.set('n', '<leader>ag', function()
  require('wtf').grep_history()
end, { desc = 'Grep history' })

vim.keymap.set('n', '<leader>ay', function()
  require('wtf').yank()
end, { desc = 'Yank message' })
