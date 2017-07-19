call plug#begin()

" Git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Languages
Plug 'fatih/vim-go'
Plug 'moll/vim-node'
Plug 'tpope/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'othree/html5.vim'
Plug 'burnettk/vim-angular'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'mxw/vim-jsx'

" Colors
Plug 'morhetz/gruvbox'

" the rest of them
Plug 'tpope/vim-surround'
Plug 'gregsexton/MatchTag'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-startify'
Plug 'edkolev/tmuxline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'

call plug#end()

set cursorline
highlight clear SignColumn
set encoding=utf-8
set number

" look better plz
set background=dark
set t_Co=256
set t_ut=
set termguicolors

colorscheme gruvbox

" Status Line
set noshowmode
let g:tmuxline_powerline_separators = 0

" leader by choice
let mapleader=","
set timeoutlen=500

" tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set smartindent
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o

" better mappings
nnoremap Y y$
imap jj <esc>
imap kk <esc>
nmap <space> :

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" pad scroll line to top with 5 lines
set scrolloff=5

set ignorecase  " case insensitive search
set smartcase   " case insensitive only if search pattern is all lowercase
set gdefault    " search/replace globally (on a line) by default

" Enter key is a stretch
nmap <C-Space> <CR>
cmap <C-Space> <CR>

" Quit
nmap <leader>q :q<CR>

" Save
nmap <leader>s :w<CR>

" File Browsing
nmap <leader>k :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Tags
" Create tags file
command! MakeTags !ctags -R .

" List JS Frameworks
let g:used_javascript_libs = 'angularjs,react'

" Allow JSX highlighting in .js
let g:jsx_ext_required = 0

" CtrlP Settings
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nmap <C-b> :CtrlPBuffer<CR>

" deliminate
let g:delimitMate_expand_cr = 2

" Startify settings
" When opening a file or bookmark, change to its directory
let g:startify_change_to_dir = 1

" set bookmarks
let g:startify_bookmarks = [ {'v': '~/.vim/nvimrc'}]

" Delete open buffers before loading a new session
let g:startify_session_delete_buffers = 0

" Delete open buffers before loading a new session
let g:startify_session_persistence = 0

" Emmet settings
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Multiple Cursors
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-D>'

" vim-go
let g:go_fmt_command='goimports'

" Easier indenting in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" toggle line numbers
nmap <leader>n :set invnumber<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=eol:¬

" handle glare in the morning
function! Glare()
  if &g:background == 'dark'
    set background=light
  else
    set background=dark
  endif
endfunction

nmap <leader>g :call Glare()<CR>

" treat JSON as JavaScript
autocmd BufNewFile,BufRead *.json set ft=javascript

" auto spell check in markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" better split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Run last command with sudo
cmap w!! %!sudo tee > /dev/null %

