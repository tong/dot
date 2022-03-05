set nocompatible
set encoding=utf-8
set number
set showmatch
set mouse=v " middle click paste with mouse
set hlsearch " highlight search results
set cc=80
set termguicolors
set autoindent
set smartindent
set tabstop=1
set nowrap
set nolist       " nolist needed for linebreak
set linebreak    " when wrapping, don't break words
set nospell  " no spellcheck by default
set spelllang=de,en
set noshowmode


"set guicursor=a:blinkon200
set guicursor=a:blinkon100
set guicursor+=i:blinkwait10
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guifont=JetBrainsMono\ Nerd\ Font\ Regular:h11

let g:colorizer_auto_color = 1

highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

let g:neovide_transparency=0.98
"let g:neovide_cursor_vfx_mode = "railgun"
let g:neovide_remember_window_size=v:true
let g:neovide_cursor_trail_length=0.8

" ---

syntax on

filetype on
filetype indent on
filetype plugin on

colorscheme gruvbox
source $HOME/.config/nvim/filetype.vim
source $HOME/.config/nvim/keymap.vim

" --- Plugins ---------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')
"Plug 'chrisbra/Colorizer'
"Plug 'ap/vim-css-color', {'for': ['css', 'less', 'scss', 'sass']}
"Plug 'skammer/vim-css-color'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}  " 
"Plug 'preservim/nerdtree'
Plug 'tyru/open-browser.vim'  " https://github.com/tyru/open-browser.vim
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'jdonaldson/vaxe'
Plug 'tong/vim-haxe'
Plug 'vim-syntastic/syntastic'
Plug 'ellisonleao/glow.nvim'
Plug 'folke/twilight.nvim'
"Plug 'norcalli/nvim-colorizer.lua'

Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go'

source $HOME/.config/nvim/plugin/coc.vim
source $HOME/.config/nvim/plugin/fzf.vim
source $HOME/.config/nvim/plugin/git-gutter.vim
source $HOME/.config/nvim/plugin/git-messenger.vim
source $HOME/.config/nvim/plugin/nerdtree.vim
source $HOME/.config/nvim/plugin/snippets.vim
source $HOME/.config/nvim/plugin/startify.vim

call plug#end()

"set CFG=$HOME/.config/nvim
"source $CFG/statusline.vim
"source $HOME/.config/nvim/statusline.vim

