set nocompatible
set encoding=utf-8
set number
set showmatch
set mouse=v " middle click paste with mouse
set hlsearch " highlight search results
set cc=80
set number
set termguicolors
set autoindent
set smartindent
set tabstop=4

set guicursor=a:blinkon200

set guifont=JetBrainsMono\ Nerd\ Font\ Regular:h11
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

syntax on

colorscheme default
filetype on

filetype indent on
filetype plugin on

" Copy/Pase
vnoremap <C-c> "*y :let @+=@*<CR>
"vnoremap <C-c> "+y
map <C-p> "+P


let g:neovide_transparency=0.98
"let g:neovide_cursor_vfx_mode = "railgun"
let g:neovide_remember_window_size=v:true
let g:neovide_cursor_trail_length=0.8

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'
Plug 'tyru/open-browser.vim'  " https://github.com/tyru/open-browser.vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jdonaldson/vaxe'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdtree'
Plug 'tyru/open-browser.vim'
call plug#end()
