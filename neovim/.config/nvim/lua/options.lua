-- global statusline
-- if not vim.g.vscode then
--   vim.o.laststatus = 3
--   vim.o.statusline = "%!v:lua.require'custom.statusline'.statusline()"
-- end

vim.o.laststatus = 0

vim.o.completeopt = 'menu,menuone,popup,fuzzy,noinsert'
vim.opt.termguicolors = true
vim.cmd.hi 'Comment gui=none'

vim.opt.ruler = true

-- Tab width
vim.opt.tabstop = 2

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = false

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

vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.autochdir = false
vim.opt.iskeyword:append '-'
vim.opt.path:append '**'
vim.opt.wildignore:append {
  'target/*',
  'node_modules/*',
  'dist/*',
  '.git/*',
  '.jj/*',
  '.vscode/*',
}
vim.opt.selection = 'exclusive'
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
