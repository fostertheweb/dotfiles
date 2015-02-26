set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" plugins from github
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'gregsexton/MatchTag'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'burnettk/vim-angular'
Plugin 'mattn/emmet-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'trusktr/seti.vim'

call vundle#end()
filetype plugin indent on
syntax on
set number
set cursorline

" look better plz
set background=dark
set t_Co=256

if !has('gui_running')
  set term=xterm-256color
endif

set t_ut=
let base16colorspace=256
colorscheme base16-mocha

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
set formatoptions-=cro

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

set laststatus=2

" CtrlP settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|dist\'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files=0
let g:ctrp_max_depth=40

" Syntastic settings
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" Airline settings
let g:airline_theme = 'base16'
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline_powerline_fonts = 1

let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

" Emmet settings
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" NERDTree
" show hidden files
let NERDTreeShowHidden=1
" open NERDTree with Control n
nnoremap <C-n> :NERDTree<CR>

" Multiple Cursors
let g:multi_cursor_next_key='<C-l>'
let g:multi_cursor_prev_key='<C-h>'

" Easier indenting in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
