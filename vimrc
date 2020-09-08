autocmd BufWritePost $MYVIMRC source $MYVIMRC
set nu
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
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif"
"=============================================================================================
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'connorholyday/vim-snazzy'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()
"=============================================================================================
"gitgutter config=====================================
"
let g:gitgutter_enabled=1
let g:gitgutter_signs=1
let g:gitgutter_sign_added = '☻'
let g:gitgutter_sign_modified = '⚡'
let g:gitgutter_sign_removed = 'zz'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'
let g:gitgutter_diff_relative_to = 'working_tree'
"let g:gitgutter_preview_win_floating = 1
set updatetime=1
"
"gitgutter config end.==============================
"
color snazzy
let g:SnazzyTransparent=1

"设置linux4.0.1内核的ctags索引
"set tags=/home/arthur/source/linux-4.0.1/tags
" 使用F2键来执行Ctrl+w+w, 也就是切换同一个终端下的不同分屏
nmap <F2> <C-w>w
" tagbar设置===================================================
" tagbar用来显示当前文件的类、结构、函数列表
let g:tagbar_width=35
nmap <F8> :TagbarToggle<CR> 
" tagbar=======================================================
"
nmap ut :UndotreeShow<CR>
nmap uu :UndotreeHide<CR>
"
"gutentags 配置
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"
"
"coc config=====================================================
set signcolumn=yes
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
