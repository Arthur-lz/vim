autocmd BufWritePost $MYVIMRC source $MYVIMRC
set nu
set relativenumber
set cursorline " 显示行线
"set cursorcolumn " 显示列线
map S :w<cr>
map Q :q<cr>
set ignorecase
set incsearch
set history=100
set showcmd
set smartcase
set wrap
set wildmenu
set scrolloff=5
"
"
"
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable  " 允许折叠
set formatoptions-=tc
set splitright
set splitbelow
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
" 自动缩进
set autoindent

set cindent
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif"
"=============================================================================================
call plug#begin('~/.vim/plugged')
"vim打开文件时，显示在vim最下面的状态栏
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"终端配色，背景透明相关
Plug 'connorholyday/vim-snazzy' 
"动态显示未保存内容与git仓库中文件差异
Plug 'airblade/vim-gitgutter' 
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'scrooloose/nerdcommenter'
"代码批量注释
Plug 'preservim/nerdcommenter'  
"代码补全，与coc-snippets配合使用
Plug 'honza/vim-snippets'  
"代码对齐
"Plug 'godlygeek/tabular' 
call plug#end()
"=============================================================================================
"
let g:gitgutter_enabled=1
"let g:gitgutter_signs=1
"let g:gitgutter_sign_added = '☻'
"let g:gitgutter_sign_modified = '⚡'
"let g:gitgutter_sign_removed = 'zz'
"let g:gitgutter_sign_removed_first_line = '^^'
"let g:gitgutter_sign_modified_removed = 'ww'
"let g:gitgutter_diff_relative_to = 'working_tree'

let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
"let g:gitgutter_preview_win_floating = 1
let mapleader=","
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>
"
"gitgutter config end.==============================
"
let g:SnazzyTransparent=1
color snazzy "这一句必须放在 let g:SnazzyTransparent=1后面，否则透明背景失效！！
"
"nmap <leader>c<space> NERDCommenterToggle
"设置linux4.0.1内核的ctags索引
set tags=/home/arthur/source/linux-4.0.1/tags
" 使用F2键来执行Ctrl+w+w, 也就是切换同一个终端下的不同分屏
nmap <F2> <C-w>w
" tagbar设置===================================================
" tagbar用来显示当前文件的类、结构、函数列表
let g:tagbar_width=35
nmap <F8> :TagbarToggle<CR> 
" tagbar=======================================================
"
nnoremap <F5> :UndotreeToggle<cr>
"
"                 let l:msg .= '♨'
"                 let l:msg .= '♺'
"

"coc config=====================================================
set signcolumn=yes
set updatetime=100
nmap <space>t :CocCommand explorer<CR>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-@> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
"=============================================================
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"coc config end.
"
if has("persistent_undo")
    set undodir=$HOME/.config/undobak/
    set undofile
endif
