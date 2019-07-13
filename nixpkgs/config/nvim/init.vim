set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
"Plugin 'Shougo/deoplete.nvim'
"Plugin 'zxqfl/tabnine-vim'
"Plugin 'tbodt/deoplete-tabnine'
let g:deoplete#enable_at_startup = 1
