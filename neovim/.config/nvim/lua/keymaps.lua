-- clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- use ; to escape in normal and visual mode
vim.keymap.set({ 'n', 'v' }, ';', '<Esc>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Close buffer/split
vim.keymap.set('n', '<C-q>', '<CMD>q<CR>', { desc = 'Quit' })

-- Close other splits
vim.keymap.set('n', '<leader>j', '<CMD>only<CR>', { desc = 'Close other splits' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Git commands
vim.keymap.set('n', '<leader>gs', '<CMD>G<CR>', { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = '[G]it [C]ommit' })
vim.keymap.set('n', '<leader>go', '<CMD>Git pull<CR>', { desc = '[G]it Pull [O]rigin' })
vim.keymap.set('n', '<leader>gp', '<CMD>Git push<CR>', { desc = '[G]it [P]ush' })

-- Write buffer
vim.keymap.set('n', '<leader>s', '<CMD>w<CR>', { desc = '[S]ave Buffer' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
