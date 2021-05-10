let mapleader=','

" Standard VI settings
set nocompatible
set clipboard+=unnamed
set noswapfile
set ignorecase
set smartcase
set number
set relativenumber
set noeol
set pastetoggle=<F2>
set backspace=indent,eol,start
set history=1000
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set showbreak=...
set wrap linebreak nolist
set visualbell t_vb=
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
set scrolloff=3
set sidescrolloff=7
set sidescroll=1
set mouse=a
set ttymouse=xterm2

set statusline=%f       "tail of the filename
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set laststatus=2

set wildmode=list:longest   "make cmdline tab completion like bash
set wildignore=*.o,*.obj,*~ 
set wildignore+=*/gen/*,*/tmp/*,*.so,*.swp,*.zip,*/_build/*,.git/*,*.dll,*.exe,*.dat

" Clear selected search
nnoremap <CR> :noh<CR><CR>
nnoremap <F1> :noh<CR><CR>

" Window and Tab management
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <Tab> gt
nmap <S-Tab> gT
map <C-w><C-[> :tabmove -1<CR>
map <C-w><C-]> :tabmove +1<CR>
nnoremap <silent> ,t     :tabe<CR>
nnoremap <silent> ,< 20<C-W><
nnoremap <silent> ,> 20<C-W>>

" Open Files
nnoremap <silent> ,oo :exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> ,o\ :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> ,o} :split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> ,o[ :vsplit<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> ,o] :vsplit<CR><C-w>l:exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> ,ot :vsplit<CR>:exec("tag ".expand("<cword>")."Test")<CR>
nnoremap <silent> ,on :split<CR><C-W>j:NERDTreeFind<CR>o<CR>

" Syntax
syntax on

" Pickle
nnoremap <silent> ,{ i{{  }}<ESC>hhi

" Open Project Files
nnoremap <silent> ,d yw:vsplit ../stackdb/db/ctdb/baseline_10.0.120/create_schema.sql<CR>/<c-r>"<CR>

" Custom commands
command! -nargs=1 File :e `find . -type f -iname <args>`
command! CopyPath let @+ = expand('%:p')

" vm-plug
call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/sideways.vim'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdcommenter'
Plug 'bogado/file-line'

call plug#end()

" Plugin: Sideways
nnoremap <silent> ,ah :SidewaysLeft<cr>
nnoremap <silent> ,al :SidewaysRight<cr>

" Plugin: NERDTree
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

nnoremap <silent> <C-f> :NERDTreeToggle<CR>

" Plugin: CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_user_command = ['.git', 'vim_ctrlp_files.sh %s']

