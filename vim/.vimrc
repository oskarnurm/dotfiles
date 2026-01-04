" general
colorscheme habamax
let mapleader = " "

set mouse=a
set confirm
set undofile
set noswapfile
set updatetime=250
set timeoutlen=300
set wildmode=noselect:lastused,full

" ui
set scrolloff=10
set number
set relativenumber
set cursorline
set splitright
set splitbelow
set termguicolors
set signcolumn=yes
set list
set listchars=tab:\ \ ,trail:·,nbsp:␣

" editing
set nowrap
set expandtab
set tabstop=2
set shiftwidth=0
set smartcase
set ignorecase
set smartindent
set spelloptions=camel 
set iskeyword=@,48-57,_,192-255,-
set completeopt=menuone,noinsert,preview

" disable some default providers
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python3_provider = 0

let g:loaded_man = 1
let g:loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_2html_plugin = 1

autocmd VimEnter * set clipboard=unnamedplus

" mappings
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

nnoremap x "_x
vnoremap x "_x
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

" window Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" search & quickfix
nnoremap <Esc> :nohlsearch<CR>
nnoremap <C-n> :cnext<CR>zz
nnoremap <C-p> :cprev<CR>zz
nnoremap q :copen<CR>
nnoremap Q :cclose<CR>
nnoremap l :lopen<CR>
nnoremap L :lclose<CR>

" move Lines
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" file Navigation
nnoremap <leader>av :vert sf #<CR>
nnoremap <leader>b :b 

let s:file_cache = []

function! FdFindFiles(cmdarg, cmdcomplete)
  " populate cache once per session
  if empty(s:file_cache)
    let s:file_cache = systemlist('fd --type f --hidden --exclude .git')
  endif

  " handle empty query
  if empty(a:cmdarg)
    return s:file_cache
  endif

  " fuzzy match against the cached list
  return matchfuzzy(s:file_cache, a:cmdarg, {'limit': 100})
endfunction

set findfunc=FdFindFiles

augroup FdFuzzyLogic
  autocmd!
  " trigger wildmenu automatically when typing ':find '
  autocmd CmdlineChanged * if getcmdline() =~# '^find\s' | call wildtrigger() | endif
  " clear memory when the command line is closed
  autocmd CmdlineLeave * let s:file_cache = []
augroup END

nnoremap <leader>f :find<Space>


