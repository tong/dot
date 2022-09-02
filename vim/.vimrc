set nocompatible
set encoding=utf-8

set autoindent
set belloff=all
set autowrite
set background=dark

set colorcolumn=+1
set cursorline

set icon
set hidden
set number
set ruler
set showmode
set smartindent
set smarttab

set ruler
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set textwidth=80
set ttyfast

"set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" highlight search hits
set hlsearch
set incsearch
set linebreak

set nobackup
set noswapfile
set nowritebackup

set omnifunc=syntaxcomplete#Complete

" autocomplete options:
set completeopt-=menu
set completeopt+=menuone   " Show the completions UI even with only 1 item
set completeopt-=longest   " Don't insert the longest common text
set completeopt-=preview   " Hide the documentation preview window (shown only if available)
set completeopt+=noinsert  " Don't insert text automatically
set completeopt-=noselect  " Highlight the first completion automatically

filetype plugin on
syntax on

" ###############################################################################

let &t_EI = "\<Esc>[2 q"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"

if v:version >= 800
    " stop vim from silently messing with files that it shouldn't
    set nofixendofline
    " better ascii friendly listchars
    set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
    " no automatic folding
    set foldmethod=manual
    set nofoldenable
endif

" ###############################################################################

let mapleader=" "

" ###############################################################################

if filereadable(expand("~/.vim/autoload/plug.vim"))
    call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    call plug#end()
    autocmd vimenter * ++nested colorscheme gruvbox
endif

