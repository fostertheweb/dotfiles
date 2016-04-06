set nocompatible

call plug#begin('~/.vim/plugged')

" plugins from github
" git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'

" syntax
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'tpope/vim-markdown'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'ekalinin/Dockerfile.vim'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'burnettk/vim-angular'
Plug 'mxw/vim-jsx'
Plug 'mustache/vim-mustache-handlebars'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'goatslacker/mango.vim'
Plug 'w0ng/vim-hybrid'
Plug 'AlessandroYorba/Sierra'
Plug 'altercation/vim-colors-solarized'

" the rest of them
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/syntastic'
Plug 'gregsexton/MatchTag'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-bundler'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-startify'
Plug 'sjl/gundo.vim'

call plug#end()

filetype plugin indent on
syntax on
set cursorline
highlight clear SignColumn
set encoding=utf-8
set number

" look better plz
set background=dark
set t_Co=256

if !has('gui_running')
  set term=xterm-256color
endif

set t_ut=
let base16colorspace=256
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme gruvbox

" leader by choice
let mapleader=","
set timeoutlen=500

" make backspace not suck
set backspace=indent,eol,start

" tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set smartindent
set autoindent
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o

" better mappings
nnoremap Y y$
imap jj <esc>
nmap <space> :

" remap U to <C-r> for easier redo
nnoremap U <C-r>

set mouse=a

" pad scroll line to top with 5 lines
set scrolloff=5

set incsearch
set ignorecase  " case insensitive search
set smartcase   " case insensitive only if search pattern is all lowercase
set gdefault    " search/replace globally (on a line) by default

set encoding=utf-8

" deliminate
let g:delimitMate_expand_cr = 2

" Allow JSX in normal JS files
let g:jsx_ext_required = 0

" Startify settings
" When opening a file or bookmark, change to its directory
let g:startify_change_to_dir = 1

" set bookmarks
let g:startify_bookmarks = [ {'v': '~/.vimrc'}, '~/Cenify/device-manager', '~/Sites/session-manager' ]

" Delete open buffers before loading a new session
let g:startify_session_delete_buffers = 0

" Delete open buffers before loading a new session
let g:startify_session_persistence = 0


" CtrlP settings
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files=0
let g:ctrp_max_depth=40
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](node_modules|bower_components|vendor|tmp|dist)|(\.(git))$',
  \ 'file': '\v\.(so|map)$'
  \ }

" The Silver Searcher
if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" grep word under cursor
nnoremap <leader>r :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
" search contents of files in given directory
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Syntastic settings
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_open = 1

" Emmet settings
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" toggle NERDTree sidebar
map <C-n> :NERDTreeToggle<CR>

" toggle Gundo
nnoremap <leader>u :GundoToggle<CR>

" Multiple Cursors
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-D>'

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

"Invisible character colors
highlight NonText guifg=#555555
highlight SpecialKey guifg=#555555

" prepare statusline for lightline
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" handle glare in the morning
function! Glare()
  if &g:background == 'dark'
    colorscheme solarized
    set background=light
  else
    colorscheme gruvbox
    set background=dark
  endif
endfunction

nmap <leader>g :call Glare()<CR>

" treat JSON as JavaScript
autocmd BufNewFile,BufRead *.json set ft=javascript

" open Gitv horizontally
let g:Gitv_OpenHorizontal = 1

" auto spell check in markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" better split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

