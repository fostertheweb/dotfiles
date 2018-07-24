call plug#begin()

" JavaScript
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'mhartington/nvim-typescript'
Plug 'leafgarland/typescript-vim'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'styled-components/vim-styled-components'

" Other Languages
Plug 'hail2u/vim-css3-syntax'
Plug 'moll/vim-node'
Plug 'tpope/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'othree/html5.vim'

" Colors
Plug 'morhetz/gruvbox'
Plug 'ap/vim-css-color'

" Code Quality
Plug 'editorconfig/editorconfig-vim'

" Utilities
Plug 'mattn/emmet-vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'gregsexton/MatchTag'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'

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

" leader by choice
let mapleader=','
set timeoutlen=800

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

" hide search highlight
nmap <leader>h :noh<CR>

" Enter key is a stretch
nmap <C-Space> <CR>
cmap <C-Space> <CR>

" Visual Block
nmap <leader>v <C-v>

" Quit
nmap <leader>q :q<CR>
nnoremap <leader>q :q<CR>

" Save
nmap <leader>s :w<CR>
nmap <C-s> :w<CR>

" List JS Frameworks
let g:used_javascript_libs = 'angularjs,react,jasmine,angularui,angularuirouter,underscore'

" deliminate
let g:delimitMate_expand_cr = 2

" Emmet settings
let g:user_emmet_leader_key='<C-e>'

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

" Lightline
let g:lightline = {
\ 'active': {
\ 'left': [['mode', 'paste'], ['filename']],
\ 'right': [[ 'lineinfo' ], [ 'percent' ]]
\ },
\ 'component_function': {
\   'filename': 'LightlineFilename',
\ }
\ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' ✶' : ''
  return filename . modified
endfunction

