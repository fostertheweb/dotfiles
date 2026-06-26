local utils = require 'utils'

vim.pack.add {
  'https://github.com/tpope/vim-fugitive',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitiveblame',
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = true })
  end,
})

vim.keymap.set({ 'n', 'x' }, 'U', '<Nop>')
vim.keymap.set('n', 'Us', '<CMD>Git<CR>', { desc = 'Stage' })
vim.keymap.set('n', 'Ud', '<CMD>Git diff<CR>', { desc = 'Diff' })
vim.keymap.set('n', 'Uc', '<CMD>Git commit<CR>', { desc = 'Commit' })
vim.keymap.set({ 'n', 'x' }, 'Ub', '<CMD>Git blame<CR>', { desc = 'Blame' })
vim.keymap.set('n', 'Ul', '<CMD>Git log --oneline --decorate<CR>', { desc = 'Log' })
vim.keymap.set('x', 'Ul', '<CMD>Gclog!<CR>', { desc = 'Log' })

-- Line mappings
vim.keymap.set('n', 'U1b', '<CMD>.,Git blame<CR>', { desc = 'Blame' })

vim.keymap.set('n', 'Uwd', utils.open_pr_diff, { desc = 'GitHub PR Diff' })
