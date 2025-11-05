vim.o.laststatus = 0 -- Hide statusline
vim.o.showmode = false
vim.o.ruler = false
vim.splitkeep = 'screen' -- Keep screen position when splitting
vim.opt.winborder = 'single' -- Single line window borders
vim.opt.completeopt = 'menuone,noselect,fuzzy,nosort' -- Completion menu behavior
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.tabstop = 2 -- Number of spaces for tab character
vim.g.mapleader = ' ' -- Set leader key to space
vim.g.maplocalleader = ' ' -- Set local leader key to space
vim.opt.number = true -- Show line numbers
vim.opt.breakindent = true -- Preserve indentation in wrapped lines
vim.opt.undofile = true -- Save undo history to file
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true -- Case sensitive if uppercase letters present
vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.updatetime = 200 -- Faster completion and diagnostics
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence
vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.pumheight = 10 -- completion popup menu
vim.opt.iskeyword:append '-' -- Treat hyphen as part of word
vim.opt.path:append ',**' -- Search recursively in subdirectories
vim.opt.splitright = true
vim.opt.swapfile = false -- Don't create swap files
vim.opt.wildmode = 'longest:full,full' -- Command completion behavior
vim.opt.wildignore:append {
  '*/target/*',
  '*/node_modules/*',
  '*/dist/*',
  '*/.git/*',
  '*/.jj/*',
  '*/.vscode/*',
}
