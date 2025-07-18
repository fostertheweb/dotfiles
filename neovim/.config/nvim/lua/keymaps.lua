local utils = require 'utils'

-- Tab to accept completion
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<Tab>'
end, { expr = true, noremap = true })

vim.keymap.set('n', '<leader>w', '<CMD>write!<CR>', { desc = 'Write' })

-- write and quit
vim.keymap.set('n', '<leader>W', '<CMD>wq!<CR>', { desc = 'Write and quit' })

-- Terminal mode escape
vim.keymap.set('t', '<C-]>', '<C-\\><C-n>')

-- q to go back a word
vim.keymap.set({ 'n', 'v' }, 'q', 'b')
vim.keymap.set({ 'n', 'v' }, 'Q', 'B')

-- use b for macros
vim.keymap.set({ 'n', 'v' }, 'b', 'q')
vim.keymap.set({ 'n', 'v' }, 'B', 'Q')

-- Close tab or quit
vim.keymap.set({ 'n', 'v' }, '<leader>Q', utils.close_tab_or_quit, { desc = 'Close tab or quit' })

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-[>', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, start of text, EOL
vim.keymap.set({ 'n', 'v' }, 'gh', '0', { desc = 'Go to beginning of line' })
vim.keymap.set({ 'n', 'v' }, 'gs', '^', { desc = 'Go to start of text' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Go to end of line' })

-- Window commands
vim.keymap.set('n', '<C-w>y', '<CMD>%y+<CR>', { desc = 'Yank window' })
vim.keymap.set('v', '<C-y>', "<CMD>'<,'>y+<CR>", { desc = 'Yank visual selection' })

-- Tab navigation
vim.keymap.set('n', '<C-x>n', '<CMD>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<C-x>p', '<CMD>tabprev<CR>', { desc = 'Previous tab' })

-- Buffer navigation
vim.keymap.set('n', '<C-f>', ':bn<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-b>', ':bp<cr>', { desc = 'Previous previous' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- D, Diagnostic keymaps
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Quickfix list' })

vim.keymap.set('n', '<leader>f', ':find ', { desc = 'Find' })
vim.keymap.set('n', '<leader><leader>', ':b ', { desc = 'Buffers' })

vim.keymap.set('n', '<C-J>', '<CMD>term lazyjj<CR>', { desc = 'Open lazyjj' })

-- G, Git commands
vim.keymap.set('n', '<C-g>', '<CMD>term gitu<CR>', { desc = 'Open gitu' })
vim.keymap.set('n', '<leader>gA', utils.git_add_all, { desc = 'Stage all changes' })
vim.keymap.set('n', '<leader>gC', '<CMD>Git commit<CR>', { desc = 'Commit' })
vim.keymap.set('n', '<leader>gP', '<CMD>Git push<CR>', { desc = 'Push' })
vim.keymap.set('n', '<leader>gL', '<CMD>Gitsigns toggle_current_line_blame<CR>', { desc = 'Blame line' })
vim.keymap.set('n', '<leader>gx', utils.open_pr_diff, { desc = 'Open GitHub PR Diff' })

-- Q, Quickfix list
vim.keymap.set('n', '<leader>qo', '<CMD>copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qq', '<CMD>cclose<CR>', { desc = 'Close quickfix list' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' })

vim.keymap.set('n', 'g.', function()
  require('tiny-code-action').code_action()
end, { desc = 'Code actions', noremap = true, silent = true })
