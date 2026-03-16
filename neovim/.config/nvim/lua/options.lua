vim.g.mapleader = ' ' -- Set leader key to space
vim.g.maplocalleader = ' ' -- Set local leader key to space

vim.opt.laststatus = 3 -- Global statusline
vim.opt.showmode = false
vim.opt.ruler = false
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true -- Preserve indentation in wrapped lines

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = 'split' -- Preview substitutions live

vim.opt.signcolumn = 'yes'
vim.opt.showmatch = true -- Highlights matching brackets
vim.opt.cmdheight = 1 -- Single line command line
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.showmode = false
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.winborder = 'single' -- Single line window borders
vim.opt.conceallevel = 0 -- Do not hide markup
vim.opt.concealcursor = '' -- Do not hide cursorline in markup
vim.opt.lazyredraw = true -- Do not redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.fillchars = { eob = ' ' } -- Hide "~" on empty lines

local undodir = vim.fn.expand '~/.vim/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto-reload changes if outside of neovim
vim.opt.autowrite = false

vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.autochdir = false
vim.opt.iskeyword:append '-'
vim.opt.path:append '**'
vim.opt.selection = 'inclusive'
vim.opt.mouse = 'a'
vim.opt.clipboard = ''
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = 'utf-8'
vim.opt.shortmess:append 'c'

vim.opt.foldmethod = 'expr' -- Use expression for folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Start with all folds open

vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right
vim.splitkeep = 'screen' -- Keep screen position when splitting

vim.opt.diffopt:append 'linematch:60' -- Improve diff display
vim.opt.redrawtime = 10000 -- Increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- Increase max memory
vim.opt.wildmenu = true -- Tab completion
vim.opt.wildmode = 'longest:full,full' -- Complete longest common match, full completion list, cycle through with Tab
vim.opt.wildignore:append {
  '*/target/*',
  '*/node_modules/*',
  '*/dist/*',
  '*/.git/*',
  '*/.jj/*',
  '*/.vscode/*',
}
