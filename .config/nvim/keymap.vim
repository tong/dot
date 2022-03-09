let mapleader = ","

" --- Select all
noremap <C-a> ggVG

" -- Move lines
nnoremap <A-j> :m .+1<CR>== " Move line down
nnoremap <A-k> :m .-2<CR>== " Move line up
"noremap <c-s-down> ddp
"noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>
"nnoremap <A-j> :m .+1<CR>==
"nnoremap <A-k> :m .-2<CR>==
"inoremap <A-j> <Esc>:m .+1<CR>==gi
"inoremap <A-k> <Esc>:m .-2<CR>==gi
"vnoremap <A-j> :m '>+1<CR>gv=gv
"vnoremap <A-k> :m '<-2<CR>gv=gv

" --- Panes
"nnoremap vs :vs<CR>
"nnoremap sp :sp<CR>
"nnoremap <C-H> <C-W><C-H> " Move to left pane "ctrl-h"
"nnoremap <C-L> <C-W><C-L> " Move to right pane "ctrl-l"
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

