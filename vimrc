set nocompatible

call plug#begin('~/.vim/plugged')

" plugins from github
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/syntastic'
Plug 'gregsexton/MatchTag'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'burnettk/vim-angular'
Plug 'mattn/emmet-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'terryma/vim-multiple-cursors'
Plug 'OrangeT/vim-csharp'
Plug 'gregsexton/gitv'
Plug 'kien/ctrlp.vim'
" colorschemes
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'

call plug#end()

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

" CtrlP settings
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files=0
let g:ctrp_max_depth=40

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

" Emmet settings
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" open cwd with netrw
nnoremap <C-N> :e .<CR>
" open dir of current file
nnoremap <C-n> :Explore<CR>

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

" handle glare in the morning
function! Glare()
  if &g:background == 'dark'
    colorscheme base16-solarized
    set background=light
  else
    colorscheme gruvbox
    set background=dark
  endif
endfunction

nmap <leader>g :call Glare()<CR>

