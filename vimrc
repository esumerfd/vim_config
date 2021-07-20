" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hints:
" :verbose imap <tab>           What is tab key bound to.
"
" Keys I forget
" ,rn - coc rename
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set incsearch            "find the next match as we type the search
set hlsearch             "hilight searches by default
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

au BufRead,BufNewFile *.repo set filetype=dosini
au BufRead,BufNewFile *.test set filetype=groovy
au BufRead,BufNewFile *.fn set filetype=groovy

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

" Open Project Files
nnoremap <silent> ,d yw:vsplit ../stackdb/db/ctdb/baseline_10.0.120/create_schema.sql<CR>/<c-r>"<CR>

" Syntax
syntax on

" Pickle
nnoremap <silent> ,{ i{{  }}<ESC>hhi

" Custom commands
command! -nargs=1 File :e `find . -type f -iname <args>`
command! CopyPath let @+ = expand('%:p')

" Search for visual selection
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" Language specific configuration
autocmd FileType cs setlocal shiftwidth=4 tabstop=4

" vm-plug
call plug#begin('~/.vim/plugged')

Plug 'AndrewRadev/sideways.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'bogado/file-line'
Plug 'godlygeek/tabular'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kevinoid/vim-jsonc'
Plug 'jiangmiao/auto-pairs'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'tpope/vim-surround'
Plug 'bkad/camelcasemotion'
Plug 'RRethy/vim-illuminate' " coc may do this
Plug 'mg979/vim-visual-multi'
Plug 'matze/vim-move'
Plug 'sotte/presenting.vim'
Plug 'fadein/vim-FIGlet'
Plug 'chrisbra/csv.vim'
Plug 'rosenfeld/rgrep.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'

call plug#end()

" Plugin: Sideways
nnoremap <silent> ,ah :SidewaysLeft<cr>
nnoremap <silent> ,al :SidewaysRight<cr>

" Plugin: NERDTree
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

nnoremap <silent> <C-f> :NERDTreeToggle<CR>
nnoremap <silent> ƒ :NERDTreeFind<CR> 

" Plugin: CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_user_command = ['.git', 'vim_ctrlp_files.sh %s']

" Plugin: vim-illuminate
let g:Illuminate_delay = 500

" Plugin: coc-nvim
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-git',
    \ 'coc-snippets',
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-css',
    \ 'coc-eslint',
    \ 'coc-html',
    \ 'coc-omnisharp',
    \ 'coc-prettier',
    \ 'coc-vetur'
    \ ]

let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-@> coc#refresh() " <c-space> for code completion

autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Plugin: auto-pairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" Plugin: coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Plugin: vim-move
let g:move_map_keys = 0
" Bind alt-j and alt-k to move up and down
nnoremap ∆ :move .+1<CR>==
nnoremap ˚ :move .-2<CR>==
inoremap ∆ <Esc>:move .+1<CR>==gi
inoremap ˚ <Esc>:move .-2<CR>==gi
vnoremap ∆ :move '>+1<CR>gv=gv
vnoremap ˚ :move '<-2<CR>gv=gv

" Plugin: presenting
au FileType md let b:presenting_slide_separator = '\v(^|\n)\#{3,}'

" Plugim: YankRing
nnoremap <silent>π :<C-U>YRReplace '-1', P<CR>   " meta-p
"nnoremap <silent>˜ :<C-U>YRReplace '1', P<CR>    " meta-n

