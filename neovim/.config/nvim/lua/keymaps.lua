local utils = require 'utils'

-- Ctrl-g as Esc
vim.keymap.set({ 'i', 'v' }, '<C-g>', '<Esc>')
vim.keymap.set({ 'i', 'v' }, '<C-;>', '<Esc>')

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-g>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-;>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', ';', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, start of text, EOL
vim.keymap.set({ 'n', 'v' }, 'gh', '0', { desc = 'Go to beginning of line' })
vim.keymap.set({ 'n', 'v' }, 'gs', '^', { desc = 'Go to start of text' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Go to end of line' })

-- Emacs style insert mode movement
-- TODO: <C-n> & <C-p> move down or up to same column
vim.keymap.set('i', '<C-a>', function()
  local current_position = vim.api.nvim_win_get_cursor(0)
  utils.move_to_start_of_line(current_position)
end, { desc = 'Go to beginning of line' })
vim.keymap.set('i', '<C-e>', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  utils.move_to_end_of_line(current_line)
end, { desc = 'Go to end of line' })
vim.keymap.set('i', '<C-f>', function()
  local current_position = vim.api.nvim_win_get_cursor(0)
  utils.move_forward(current_position)
end, { desc = 'Go forward' })
vim.keymap.set('i', '<C-b>', function()
  local current_position = vim.api.nvim_win_get_cursor(0)
  utils.move_backward(current_position)
end, { desc = 'Go backward' })
vim.keymap.set('i', '<C-k>', function()
  utils.cut()
end, { desc = 'Cut to end of line' })
vim.keymap.set('i', '<C-y>', function()
  utils.paste()
end, { desc = 'Yank from " register' })

-- Window commands
vim.keymap.set('n', '<C-w>y', '<CMD>%y+<CR>', { desc = 'Yank window' })

-- Write buffer
vim.keymap.set('n', '<leader>w', '<CMD>w<CR>', { desc = 'Write' })
vim.keymap.set('n', '<leader>W', '<CMD>wq<CR>', { desc = 'Write & quit' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Ctrl-Tab for tabs
vim.keymap.set('n', '<C-Tab>', '<CMD>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<C-S-Tab>', '<CMD>tabprevious<CR>', { desc = 'Previous tab' })

-- D, Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Error messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Quickfix list' })

-- G, Git commands
vim.keymap.set('n', '<leader>gs', '<CMD>TigOpenStatus<CR>', { desc = 'Status' })
vim.keymap.set('n', '<leader>gc', '<CMD>TigOpenLog<CR>', { desc = 'Log' })
vim.keymap.set('n', '<leader>gl', '<CMD>Gitsigns blame_line<CR>', { desc = 'Blame line' })
vim.keymap.set('n', '<leader>gwd', utils.open_pr_diff, { desc = 'GitHub PR Diff' })

-- Q, Quickfix list
vim.keymap.set('n', '<leader>qo', '<CMD>copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' })
