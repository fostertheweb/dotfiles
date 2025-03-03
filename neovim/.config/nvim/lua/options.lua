vim.o.statusline = "%!v:lua.require'custom.statusline'.statusline()"

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  callback = function()
    vim.wo.statusline = "%!v:lua.require('custom.statusline').statusline()"
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  callback = function()
    local winid = vim.api.nvim_get_current_win()
    vim.wo.statusline = string.format("%%!v:lua.require('custom.statusline').inactive_statusline(%d)", winid)
  end,
})

-- vim.api.nvim_create_autocmd('WinLeave', {
--   group = vim.api.nvim_create_augroup('InactiveStatusline', { clear = true }),
--   pattern = '*',
--   callback = function()
--     vim.opt_local.statusline = "%!v:lua.require'custom.statusline'.inactive_statusline()"
--   end,
-- })

-- vim.api.nvim_create_autocmd({ 'BufEnter', 'WinClosed', 'WinEnter' }, {
--   group = vim.api.nvim_create_augroup('ActiveStatusline', { clear = true }),
--   pattern = '*',
--   callback = function()
--     vim.opt_local.statusline = "%!v:lua.require'custom.statusline'.statusline()"
--   end,
-- })

vim.opt.ruler = false

-- Tab width
vim.opt.tabstop = 2

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- completion popup menu
vim.opt.pumheight = 20
