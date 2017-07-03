if has("win32")
  call plug#begin('~/vimfiles/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Git
Plug 'tpope/vim-fugitive'

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

" Better Code
Plug 'scrooloose/syntastic'

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
set showmode
set laststatus=2
set statusline=[%n]
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ %y
set statusline+=\ %l/%L

" let g:tmuxline_powerline_separators = 0

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

" Save
nmap <leader>s :w<CR>

" File Browsing
nmap <leader>k :NERDTreeToggle<CR>

" Tags
" Create tags file
command! MakeTags !ctags -R .

" List JS Frameworks
let g:used_javascript_libs = 'angularjs,react'

" Allow JSX highlighting in .js
let g:jsx_ext_required = 0

" deliminate
let g:delimitMate_expand_cr = 2

" Startify settings
" When opening a file or bookmark, change to its directory
let g:startify_change_to_dir = 1

" set bookmarks
let g:startify_bookmarks = [ {'v': '~/.vim/vimrc'}]

" Delete open buffers before loading a new session
let g:startify_session_delete_buffers = 0

" Delete open buffers before loading a new session
let g:startify_session_persistence = 0

" Syntastic settings
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_check_on_open = 1

" Emmet settings
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

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

