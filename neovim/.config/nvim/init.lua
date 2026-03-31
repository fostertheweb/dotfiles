vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.laststatus = 3
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
vim.opt.completeopt = 'menuone,noselect,fuzzy,nosort'
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

vim.env.GIT_EXTERNAL_DIFF = nil
vim.opt.diffexpr = ''
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

vim.keymap.set('n', '<leader>w', '<CMD>write!<CR>', { desc = 'Write' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>Q', '<CMD>wq<CR>', { desc = ':wq' })

-- Terminal mode escape
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>')

-- q to go back a word
vim.keymap.set({ 'n', 'v' }, 'q', 'b')
vim.keymap.set({ 'n', 'v' }, 'Q', 'B')

-- use b for macros
vim.keymap.set({ 'n', 'v' }, 'b', 'q')
vim.keymap.set({ 'n', 'v' }, 'B', 'Q')

-- Clear search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Override s default behavior
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

-- Go home, start of text, EOL
vim.keymap.set({ 'n', 'v' }, 'gh', '0', { desc = 'Go to beginning of line' })
vim.keymap.set({ 'n', 'v' }, 'gs', '^', { desc = 'Go to start of text' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Go to end of line' })

-- Window commands
vim.keymap.set('n', '<C-w>y', '<CMD>%y+<CR>', { desc = 'Yank window' })
vim.keymap.set('v', '<C-y>', "<CMD>'<,'>y+<CR>", { desc = 'Yank visual selection' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { desc = 'Yank to clipboard' })

-- Buffer navigation
vim.keymap.set('n', '<C-w>f', '<CMD>bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-w>b', '<CMD>bp<CR>', { desc = 'Previous buffer' })

-- Center cursor after page down/up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- page down/up
vim.keymap.set('t', '<S-C-u>', '<PageUp>')
vim.keymap.set('t', '<S-C-d>', '<PageDown>')

-- Move selected line up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- F, builtin find
vim.keymap.set('n', '<leader>ff', ':find ', { desc = 'Files' })

require('vim._core.ui2').enable {
  enable = true, -- Whether to enable or disable the UI.
  msg = { -- Options related to the message module.
    ---@type 'cmd'|'msg' Default message target, either in the
    ---cmdline or in a separate ephemeral message window.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds and triggers to a target.
    targets = 'cmd',
    cmd = { -- Options related to messages in the cmdline window.
      height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = { -- Options related to dialog window.
      height = 0.5, -- Maximum height.
    },
    msg = { -- Options related to msg window.
      height = 0.5, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = { -- Options related to message window.
      height = 1, -- Maximum height.
    },
  },
}

local term_group = vim.api.nvim_create_augroup('TerminalBehaviorGroup', { clear = true })

vim.api.nvim_create_autocmd('TabClosed', {
  group = term_group,
  desc = 'Tab closed, return to terminal buffer',
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd 'startinsert'
    end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = term_group,
  desc = 'Terminal buffer appearence',
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd 'startinsert'
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  group = term_group,
  pattern = '*',
  callback = function()
    vim.schedule(function()
      local bufname = vim.fn.expand '<afile>'
      if vim.bo.buftype == 'terminal' and vim.v.shell_error == 0 and bufname == '' then
        vim.cmd('bdelete! ' .. vim.fn.expand '<abuf>')
      end
    end)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start commit editor in insert mode',
  pattern = { 'gitcommit', 'gitrebase', 'COMMIT_EDITMSG' },
  callback = function(ev)
    vim.bo[ev.buf].bufhidden = 'wipe'
    vim.cmd 'startinsert'
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Update path via fd for find command',
  pattern = '*',
  callback = function()
    if vim.fn.executable 'fd' == 1 then
      local fd_results = vim.fn.systemlist 'fd --type f --hidden --follow --exclude .git'
      local dirs = {}
      for _, file in ipairs(fd_results) do
        local dir = vim.fn.fnamemodify(file, ':h')
        dirs[dir] = true
      end
      local path_list = {}
      for dir, _ in pairs(dirs) do
        table.insert(path_list, dir)
      end
      vim.o.path = table.concat(path_list, ',')
    end
    local fd_results = vim.fn.systemlist 'fd --type f --hidden --follow --exclude .git'
    local dirs = {}
    for _, file in ipairs(fd_results) do
      local dir = vim.fn.fnamemodify(file, ':h')
      dirs[dir] = true
    end
    local path_list = {}
    for dir, _ in pairs(dirs) do
      table.insert(path_list, dir)
    end
    vim.o.path = table.concat(path_list, ',')
  end,
})

-- vim: ts=2 sts=2 sw=2 et
