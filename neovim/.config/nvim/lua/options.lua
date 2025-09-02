vim.o.laststatus = 3 -- Global statusline
vim.splitkeep = 'screen' -- Keep screen position when splitting
vim.opt.winborder = 'single' -- Single line window borders
vim.opt.completeopt = 'menu,menuone,popup,fuzzy,noinsert' -- Completion menu behavior
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.cmd.hi 'Comment gui=none' -- Remove italic from comments
vim.opt.ruler = true -- Show cursor position in status line
vim.opt.tabstop = 2 -- Number of spaces for tab character
vim.g.mapleader = ' ' -- Set leader key to space
vim.g.maplocalleader = ' ' -- Set local leader key to space
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.breakindent = true -- Preserve indentation in wrapped lines
vim.opt.undofile = true -- Save undo history to file
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true -- Case sensitive if uppercase letters present
vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.updatetime = 200 -- Faster completion and diagnostics
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.hlsearch = true -- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.pumheight = 20 -- completion popup menu
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.errorbells = false -- Disable error bells
vim.opt.backspace = 'indent,eol,start' -- Allow backspace over everything
vim.opt.autochdir = false -- Don't change directory automatically
vim.opt.iskeyword:append '-' -- Treat hyphen as part of word
vim.opt.path:append ',**' -- Search recursively in subdirectories
vim.opt.wildmenu = true -- Enhanced command line completion
vim.opt.wildmode = 'longest:full,full' -- Command completion behavior
vim.opt.wildignore:append {
  '*/target/*',
  '*/node_modules/*',
  '*/dist/*',
  '*/.git/*',
  '*/.jj/*',
  '*/.vscode/*',
}
vim.opt.selection = 'exclusive' -- Don't include character under cursor in selection
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before overwriting
vim.opt.swapfile = false -- Don't create swap files
