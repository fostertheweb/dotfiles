set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" plugins from github
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/syntastic'
Plugin 'gregsexton/MatchTag'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'burnettk/vim-angular'
Plugin 'mattn/emmet-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'terryma/vim-multiple-cursors'
" colorschemes
Plugin 'morhetz/gruvbox'

call vundle#end()
filetype plugin indent on
syntax on
set cursorline
highlight clear SignColumn

" look better plz
set background=dark
set t_Co=256

if !has('gui_running')
  set term=xterm-256color
endif

set t_ut=
let base16colorspace=256
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


" CtrlP settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|dist\'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files=0
let g:ctrp_max_depth=40

" Syntastic settings
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" Emmet settings
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" open cwd with netrw
nnoremap <C-n> :e .<CR>

" Multiple Cursors
let g:multi_cursor_next_key='<C-l>'
let g:multi_cursor_prev_key='<C-h>'

" Easier indenting in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" toggle line numbers
nmap <leader>n :set invnumber<CR>

" edit contents of statusline
set laststatus=2
set statusline=
set statusline +=[%n]              "buffer number
set statusline +=\ %<%F            "full path
set statusline +=%m                "modified flag
set statusline +=%r                "read-only flag
set statusline +=%=(%{fugitive#head()})
set statusline +=%=\ %l             "current line
set statusline +=/%L               "total lines
set statusline +=%=\ %{SyntasticStatuslineFlag()}

