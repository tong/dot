set nocompatible
set autoindent
set cursorline
set number
"set number relativenumber
set encoding=utf-8
set showmatch
"set formatoptions+=o    " Continue comment marker in new lines.
"set expandtab           " Insert spaces when TAB is pressed.
"set tabstop=4           " Render TABs using this many spaces.
"set shiftwidth=4
"set nojoinspaces
set cc=80
set ttyfast
set clipboard=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set mouse=a
set termguicolors

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

syntax on
filetype plugin on
filetype indent on
colorscheme gruvbox

set guifont=JetBrainsMono\ Nerd\ Font:h9
set guicursor=a:blinkon100
"set guicursor+=i:blinkwait10

call plug#begin('~/.local/share/nvim/plugged')
Plug 'ryanoasis/vim-devicons'
Plug 'ellisonleao/glow.nvim'
Plug 'chr4/nginx.vim'
Plug 'ap/vim-css-color'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'editorconfig/editorconfig-vim'
Plug 'dstein64/nvim-scrollview'
source $HOME/.config/nvim/plugin/airline.vim
source $HOME/.config/nvim/plugin/coc.vim
source $HOME/.config/nvim/plugin/fugitive.vim
source $HOME/.config/nvim/plugin/fzf.vim
source $HOME/.config/nvim/plugin/git-gutter.vim
source $HOME/.config/nvim/plugin/git-messenger.vim
source $HOME/.config/nvim/plugin/haxe.vim
source $HOME/.config/nvim/plugin/nerdcommenter.vim
source $HOME/.config/nvim/plugin/nerdtree.vim
source $HOME/.config/nvim/plugin/open-browser.vim
source $HOME/.config/nvim/plugin/ranger.vim
source $HOME/.config/nvim/plugin/startify.vim
source $HOME/.config/nvim/plugin/tabs.vim
call plug#end()

let g:neovide_transparency=0.98
"let g:neovide_cursor_vfx_mode = "railgun"
"let g:neovide_remember_window_size=v:true
"let g:neovide_cursor_trail_length=0.8

source $HOME/.config/nvim/keymap.vim
