call plug#begin()

" Git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

" JavaScript
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'mhartington/nvim-typescript'
Plug 'leafgarland/typescript-vim'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'styled-components/vim-styled-components'

" Other Languages
Plug 'othree/csscomplete.vim'
Plug 'moll/vim-node'
Plug 'tpope/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'othree/html5.vim'

" Colors
Plug 'morhetz/gruvbox'

" File Navigation / Search
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Code Quality
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Utilities
Plug 'mattn/emmet-vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'gregsexton/MatchTag'
" Plug 'BurningEther/nvimux'
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
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
imap hh <esc>
imap jj <esc>
imap kk <esc>
imap lll <esc>
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

" File Browsing
nmap <leader>k :NERDTreeToggle<CR>
nmap <C-b> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Search within files with Ack.vim
cnoreabbrev Ack Ack!
nmap <leader>f :Ag<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" List JS Frameworks
let g:used_javascript_libs = 'angularjs,react,jasmine,angularui,angularuirouter,underscore'

" fzf settings
nmap <leader>t :Files<CR>
nmap <C-p> :Files<CR>
nmap <leader>b :Buffers<CR>

" Terminal settings
tnoremap <C-[> <C-\><C-n>
nnoremap <leader>j :below 10sp term://$SHELL<cr>i

" Linter settings
let g:ale_fixers = {
\   'javascript': ['eslint'],
\ }

" open LocationList
nmap <leader>p :lopen<CR>

" deliminate
let g:delimitMate_expand_cr = 2

" Deoplete
let g:deoplete#enable_at_startup = 1

" Emmet settings
let g:user_emmet_leader_key='<C-e>'

" Easier indenting in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" GitGutter
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'

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

" CSS Completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

" SuperTab
let g:SuperTabDefaultCompletionType = '<c-n>'

" nvimux settings
" lua require('nvimux').bootstrap()

" Lightline
let g:lightline = {
\ 'active': {
\ 'left': [['mode', 'paste'], ['filename']],
\ 'right': [[ 'lineinfo' ], [ 'percent' ], [ 'linter_warnings', 'linter_errors', 'linter_ok' ]]
\ },
\ 'component_function': {
\   'filename': 'LightlineFilename',
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'ok'
\ },
\ }

autocmd User ALELint call lightline#update()

" ale + lightline
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆' all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' ✶' : ''
  return filename . modified
endfunction

