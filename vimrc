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
"set formatoptions-=tc
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
" markdown-preview用于实时预览正在编辑的md文件，for跟的参数表示只有打开markdown类型的文件时vim才加载下面的这插件,提升vim效率
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': ['markdown', 'vim-plug']}
"Plug 'xavierd/clang_complete'
"Plug 'justmao945/vim-clang'
"Plug 'prabirshrestha/vim-lsp'
Plug 'ycm-core/YouCompleteMe'
call plug#end()
"=============================================================================================
"
"let g:ycm_server_python_interpreter='/usr/bin/python'
" ycm 配置

	let g:ycm_use_clangd = 1 
	let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
        let g:ycm_key_list_select_completion=['<c-n>']
        let g:ycm_key_list_previous_completion=['<c-p>']
 
        let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
        let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
        let g:ycm_min_num_of_chars_for_completion=1 " 从第1个键入字符就开始罗列匹配项
        let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配项
 
        let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
"         nnoremap <F6> :YcmForceCompileAndDiagnostics<CR> "force recomile with syntastic
        "nnoremap <leader>lo :lopen<CR> "open locationlist
        "nnoremap <leader>lc :lclose<CR>    "close locationlist
 
        "inoremap <leader><leader> <C-x><C-o>
        let g:ycm_complete_in_comments = 1 "在注释输入中也能补全
        let g:ycm_complete_in_strings = 1 "在字符串输入中也能补全
        let g:ycm_collect_identifiers_from_comments_and_strings = 0 "注释和字符串中的文字也会被收入补全
 
        let g:ycm_max_num_identifier_candidates = 50
        let g:ycm_auto_trigger = 1
 
        let g:ycm_error_symbol = '>>'
        let g:ycm_warning_symbol = '>'

	autocmd FileType cpp,hpp,h,c :call coc#config("suggest.autoTrigger", "none")
	autocmd FileType cpp,hpp,h,c let b:coc_suggest_disable=1
"
let g:mkdp_browser = ''
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
"-- omnicppcomplete setting --
"set completeopt=menu,menuone,preview
"let OmniCpp_MayCompleteDot = 1 " autocomplete with .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
"let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
"let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype  in popup window
"let OmniCpp_GlobalScopeSearch=1
"let OmniCpp_DisplayMode=1
"let OmniCpp_DefaultNamespaces=["std"]
"
"source markdownrc
"
let g:SnazzyTransparent=1
color snazzy "这一句必须放在 let g:SnazzyTransparent=1后面，否则透明背景失效！！
"
"nmap <leader>c<space> NERDCommenterToggle
set tags=/home/arthur/linux/driver/net/r8168/src/tags
"set tags+=/home/arthur/linux/src/linux-5.8.9/tags
"set tags=/home/arthur/linux/driver/net/e1000e-3.8.4/src/tags
"设置linux4.0.1内核的ctags索引
"set tags=/home/arthur/esd/licheepi/linux/zero-4.10.y/tags

set tags+=/home/arthur/linux/src/linux-4.0.1/tags
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
" clangd配置

"end clang配置
filetype plugin indent on 

"打开文件类型检测, 加了这句才可以用智能补全

"coc config end.
"
if has("persistent_undo")
    set undodir=$HOME/.config/undobak/
    set undofile
endif

"cscope配置
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <silent><F7> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <silent><F3> :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <silent><F4> :cs find c <C-R>=expand("<cword>")<CR><CR>

"下一个匹配的
nmap <C-n> :cn<CR>
"前一个匹配的
nmap <C-p> :cp<CR> 
"打开quickfix窗口
nmap <C-j> :cw<CR> 
"关闭quickfix窗口
nmap <C-k> :cclose<CR> 

	
"cscope配置结束 
