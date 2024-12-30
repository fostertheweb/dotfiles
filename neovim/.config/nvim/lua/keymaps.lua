-- Function to move cursor to the end of a specific line
local function move_to_end_of_line(line_number)
  local bufnr = 0 -- Current buffer
  local lines = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)

  if #lines > 0 then
    local line_length = #lines[1]
    vim.api.nvim_win_set_cursor(0, { line_number, line_length })
  else
    print 'Line does not exist!'
  end
end

-- Ctrl-g as Esc
vim.keymap.set({ 'i', 'v' }, '<C-g>', '<Esc>')

-- ; as Esc
vim.keymap.set({ 'n', 'v' }, ';', '<Esc>')

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-g>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', ';', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, go to EOL
vim.keymap.set({ 'n', 'v' }, 'gh', '^', { desc = 'Go to beginning of line' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Go to end of line' })

-- TODO: C-y paste " register, C-k delete in front of cursor
vim.keymap.set('i', '<C-a>', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_win_set_cursor(0, { current_line, 0 })
end, { desc = 'Go to beginning of line' })
vim.keymap.set('i', '<C-e>', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  move_to_end_of_line(current_line)
end, { desc = 'Go to end of line' })

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
-- vim.keymap.set('n', '<leader>gs', '<CMD>vertical Git<CR>', { desc = 'Status' })
-- vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = 'Commit' })
-- vim.keymap.set('n', '<leader>gp', '<CMD>Git pull<CR>', { desc = 'Pull' })
-- vim.keymap.set('n', '<leader>gP', '<CMD>Git push<CR>', { desc = 'Push' })
vim.keymap.set('n', '<leader>gl', '<CMD>Gitsigns blame_line<CR>', { desc = 'Blame line' })

-- Q, Quickfix list
vim.keymap.set('n', '<leader>qo', '<CMD>copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>qn', '<CMD>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>qp', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' })
