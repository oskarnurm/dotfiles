" general
colorscheme habamax
let mapleader = " "

set mouse=a
set clipboard=unnamedplus
set confirm
set undofile
set noswapfile
set updatetime=250
set timeoutlen=300

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
set wildmode=noselect:lastused,full
set wildoptions=pum


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
set grepprg=rg\ --vimgrep\ --hidden\ --smart-case

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

" grep & quickfix
nnoremap <Esc> :nohlsearch<CR>
nnoremap <C-n> :cnext<CR>zz
nnoremap <C-p> :cprev<CR>zz
nnoremap <leader>g :copen <bar> silent grep!<space>

" move Lines
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" file Navigation
nnoremap <leader>av :vert sf #<CR>
nnoremap <leader>b :b 
nnoremap <leader>f :find<Space>


func Find(arg, _)
  if empty(s:filescache)
    let s:filescache = systemlist('fd --type f --color=never --follow --hidden --exclude .git')
  endif
  return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
endfunc
let s:filescache = []
set findfunc=Find

autocmd CmdlineEnter : let s:filescache = []
autocmd CmdlineChanged [:\/\?] call wildtrigger()
autocmd CmdlineLeavePre :
      \ if get(cmdcomplete_info(), 'matches', []) != [] |
      \   let s:info = cmdcomplete_info() |
      \   if getcmdline() =~ '^\s*fin\%[d]\s' && s:info.selected == -1 |
      \     call setcmdline($'find {s:info.matches[0]}') |
      \   endif |
      \ endif



