-- Ctrl-g as Esc
vim.keymap.set({ 'i', 'v' }, '<C-g>', '<Esc>')

-- clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-g>', '<cmd>nohlsearch<CR>')

-- override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- go home, go to EOL
vim.keymap.set({ 'n' }, 'gh', '^', { desc = '[G]oto beginning of line' })
vim.keymap.set({ 'n' }, 'gl', '$', { desc = '[G]oto to end of line' })

-- use ; to escape in normal and visual mode
vim.keymap.set({ 'n', 'v' }, ';', '<Esc>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next [D]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = '[D]iagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[D]iagnostic [Q]uickfix list' })

-- Close other splits
vim.keymap.set('n', '<C-w><C-o>', '<CMD>only<CR>', { desc = 'Close other splits' })

-- Git commands
vim.keymap.set('n', '<leader>gs', '<CMD>vertical Git<CR>', { desc = '[G]it [S]tage' })
vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = '[G]it [C]ommit' })
vim.keymap.set('n', '<leader>gp', '<CMD>Git pull<CR>', { desc = '[G]it [p]ull' })
vim.keymap.set('n', '<leader>gP', '<CMD>Git push<CR>', { desc = '[G]it [P]ush' })
vim.keymap.set('n', '<leader>gb', '<CMD>Gitsigns blame_line<CR>', { desc = '[G]it [B]lame Line' })
vim.keymap.set('n', '<leader>gr', '<CMD>Octo pr list<CR>', { desc = '[G]it [R]eview PR' })
vim.keymap.set('n', '<leader>gw', function()
  local branch = vim.fn.system 'git branch --show-current 2>/dev/null'
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  Snacks.gitbrowse.open {
    what = 'file',
    branch = branch:match '^%s*(.-)%s*$',
    line_count = line_number,
  }
end, { desc = 'Open [G]itHub [W]eb' })

-- Code commands
vim.keymap.set('n', '<leader>cc', '<CMD>CodeCompanionChat<CR>', { desc = 'LLM: [C]ode [C]hat' })
vim.keymap.set('n', '<leader>cp', '<CMD>CodeCompanion<CR>', { desc = 'LLM: [C]ode [P]rompt' })

-- Write buffer
vim.keymap.set('n', '<leader>w', '<CMD>w<CR>', { desc = '[W]rite Buffer' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
