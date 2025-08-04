if not vim.g.vscode then
  vim.opt.laststatus = 3 -- global statusline
  vim.opt.statusline = "%!v:lua.require'custom.statusline'.statusline()"
  vim.splitkeep = 'screen'
end

vim.opt.winborder = 'single'
vim.opt.completeopt = 'menu,menuone,popup,fuzzy,noinsert'
vim.opt.termguicolors = true
vim.cmd.hi 'Comment gui=none'
vim.opt.ruler = true
vim.opt.tabstop = 2
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.hlsearch = true -- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.pumheight = 20 -- completion popup menu
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.autochdir = false
vim.opt.iskeyword:append '-'
vim.opt.path:append '**'
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore:append {
  '*/target/*',
  '*/node_modules/*',
  '*/dist/*',
  '*/.git/*',
  '*/.jj/*',
  '*/.vscode/*',
}
vim.opt.selection = 'exclusive'
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
