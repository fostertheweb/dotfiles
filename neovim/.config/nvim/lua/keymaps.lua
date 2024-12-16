-- Ctrl-g as Esc
vim.keymap.set({ 'i', 'v' }, '<C-g>', '<Esc>')

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-g>', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, go to EOL
vim.keymap.set({ 'n' }, 'gh', '^', { desc = 'Go to beginning of line' })
vim.keymap.set({ 'n' }, 'gl', '$', { desc = 'Go to end of line' })

-- use ; to escape in normal and visual mode
vim.keymap.set({ 'n', 'v' }, ';', '<Esc>')

-- Window commands
vim.keymap.set('n', '<C-w>y', '<CMD>%y+<CR>', { desc = 'Yank window' })

-- Write buffer
vim.keymap.set('n', '<leader>w', '<CMD>w<CR>', { desc = 'Write' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- D, Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Error messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Quickfix list' })

-- G, Git commands
vim.keymap.set('n', '<leader>gs', '<CMD>vertical Git<CR>', { desc = 'Status' })
vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = 'Commit' })
vim.keymap.set('n', '<leader>gp', '<CMD>Git pull<CR>', { desc = 'Pull' })
vim.keymap.set('n', '<leader>gP', '<CMD>Git push<CR>', { desc = 'Push' })
vim.keymap.set('n', '<leader>gl', '<CMD>Gitsigns blame_line<CR>', { desc = 'Blame line' })
vim.keymap.set('n', '<leader>gr', '<CMD>Octo pr list<CR>', { desc = 'Review PR' })

-- Q, Quickfix list
vim.keymap.set('n', '<leader>qo', '<CMD>copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' })
