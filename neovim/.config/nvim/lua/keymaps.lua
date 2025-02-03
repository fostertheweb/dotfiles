local utils = require 'utils'

-- Ctrl-g, Ctrl-Space as Esc
vim.keymap.set({ 'i', 'v' }, '<C-g>', '<Esc>')
vim.keymap.set({ 'i', 'v' }, '<C-Space>', '<Esc>')

-- Close tab or quit
vim.keymap.set({ 'n', 'v' }, 'Q', utils.close_tab_or_quit, { desc = 'Close tab or quit' })

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-g>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-Space>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', ';', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, start of text, EOL
vim.keymap.set({ 'n', 'v' }, 'gh', '0', { desc = 'Go to beginning of line' })
vim.keymap.set({ 'n', 'v' }, 'gs', '^', { desc = 'Go to start of text' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Go to end of line' })

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

-- D, Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Quickfix list' })

-- G, Git commands
vim.keymap.set('n', '<leader>gs', '<CMD>TigOpenStatus<CR>', { desc = 'Status' })
vim.keymap.set('n', '<leader>gc', '<CMD>TigOpenCommits<CR>', { desc = 'Commits' })
vim.keymap.set('n', '<leader>gl', '<CMD>Gitsigns toggle_current_line_blame<CR>', { desc = 'Blame line' })
vim.keymap.set('n', '<leader>gx', utils.open_pr_diff, { desc = 'Open GitHub PR Diff' })

-- Q, Quickfix list
vim.keymap.set('n', '<leader>qo', '<CMD>copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qq', '<CMD>cclose<CR>', { desc = 'Close quickfix list' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' })

-- Emacs style insert mode movement
local imap = function(keys, fn, desc)
  vim.keymap.set('i', keys, function()
    fn()
  end, { desc = desc })
end

-- TODO: <C-n> & <C-p> move down or up to same column
imap('<C-a>', utils.move_to_start_of_line, 'Go to line start')
imap('<C-e>', utils.move_to_end_of_line, 'Go to line end')
imap('<C-f>', utils.move_forward, 'Go forward')
imap('<C-b>', utils.move_backward, 'Go backward')
imap('<C-k>', utils.cut, 'Cut to line end')
imap('<C-y>', utils.paste, 'Yank from " register')
