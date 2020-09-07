set nu
"au ReadPostBuf
map S :w<cr>
map Q :q<cr>
set ignorecase
set incsearch
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
call plug#end()

