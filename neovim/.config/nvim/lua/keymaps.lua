local utils = require 'utils'

-- Tab to accept completion
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<Tab>'
end, { expr = true, noremap = true })

vim.keymap.set('n', '<leader>w', '<CMD>write!<CR>', { desc = 'Write' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>Q', '<CMD>wq<CR>', { desc = ':wq' })

-- Terminal mode escape
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>')

-- q to go back a word
vim.keymap.set({ 'n', 'v' }, 'q', 'b')
vim.keymap.set({ 'n', 'v' }, 'Q', 'B')

-- use b for macros
vim.keymap.set({ 'n', 'v' }, 'b', 'q')
vim.keymap.set({ 'n', 'v' }, 'B', 'Q')

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, start of text, EOL
vim.keymap.set({ 'n', 'v' }, 'gh', '0', { desc = 'Go to beginning of line' })
vim.keymap.set({ 'n', 'v' }, 'gs', '^', { desc = 'Go to start of text' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Go to end of line' })

-- Window commands
vim.keymap.set('n', '<C-w>y', '<CMD>%y+<CR>', { desc = 'Yank window' })
vim.keymap.set('v', '<C-y>', "<CMD>'<,'>y+<CR>", { desc = 'Yank visual selection' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { desc = 'Yank to clipboard' })

-- Buffer navigation
vim.keymap.set('n', '<C-w>f', '<CMD>bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-w>b', '<CMD>bp<CR>', { desc = 'Previous buffer' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- page down/up
vim.keymap.set('t', '<S-C-u>', '<PageUp>')
vim.keymap.set('t', '<S-C-d>', '<PageDown>')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- G, Git commands
vim.keymap.set('n', '<leader>gb', '<CMD>Gitsigns toggle_current_line_blame<CR>', { desc = 'Blame line' })
vim.keymap.set('n', '<leader>gx', utils.open_pr_diff, { desc = 'Open GitHub PR Diff' })

-- Q, Quickfix list
vim.keymap.set('n', '<leader>qo', '<CMD>copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qq', '<CMD>cclose<CR>', { desc = 'Close quickfix list' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' })
