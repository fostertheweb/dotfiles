-- Ctrl-g as Esc
vim.keymap.set({ 'i', 'v' }, '<C-g>', '<Esc>')

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-g>', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, go to EOL
vim.keymap.set({ 'n' }, 'gh', '^', { desc = '[G]oto beginning of line' })
vim.keymap.set({ 'n' }, 'gl', '$', { desc = '[G]oto to end of line' })

-- use ; to escape in normal and visual mode
vim.keymap.set({ 'n', 'v' }, ';', '<Esc>')

-- Close other splits
vim.keymap.set('n', '<C-w><C-o>', '<CMD>only<CR>', { desc = 'Close other splits' })

-- Write buffer
vim.keymap.set('n', '<leader>w', '<CMD>w<CR>', { desc = '[W]rite Buffer' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Undo tree
vim.keymap.set('n', '<leader>u', '<CMD>Telescope undo<CR>', { desc = '[U]ndo tree' })

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'

-- Files
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = '[F]ind [P]roject Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Help
vim.keymap.set('n', '<leader>hf', builtin.help_tags, { desc = '[H]elp [F]ind' })
vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = '[H]elp [K]eymaps' })
vim.keymap.set('n', '<leader>ht', builtin.builtin, { desc = '[H]elp [T]elescope' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>f/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[F]ind [/] in Open Files' })

-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>fn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[F]ind [N]eovim files' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next [D]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = '[D]iagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[D]iagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>df', builtin.diagnostics, { desc = '[D]iagnostics [F]ind' })

-- Git commands
vim.keymap.set('n', '<leader>gs', '<CMD>vertical Git<CR>', { desc = '[G]it [S]tage' })
vim.keymap.set('n', '<leader>gc', '<CMD>Git commit<CR>', { desc = '[G]it [C]ommit' })
vim.keymap.set('n', '<leader>gp', '<CMD>Git pull<CR>', { desc = '[G]it [p]ull' })
vim.keymap.set('n', '<leader>gP', '<CMD>Git push<CR>', { desc = '[G]it [P]ush' })
vim.keymap.set('n', '<leader>go', builtin.git_branches, { desc = '[G]it Check[o]ut Branch' })
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
vim.keymap.set('n', '<leader>cy', '<CMD>%y+<CR>', { desc = '[C]ode [Y]ank Buffer' })

-- Navigate tree
vim.keymap.set('n', '<C-j>', require('treewalker').move_down, { noremap = true })
vim.keymap.set('n', '<C-k>', require('treewalker').move_up, { noremap = true })
vim.keymap.set('n', '<C-h>', require('treewalker').move_out, { noremap = true })
vim.keymap.set('n', '<C-l>', require('treewalker').move_in, { noremap = true })
