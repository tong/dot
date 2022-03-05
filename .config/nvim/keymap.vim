let mapleader = ","

" select all
noremap <C-a> ggVG

" -- Copy/Pase
vnoremap <C-c> "*y :let @+=@*<CR>
"vnoremap <C-c> "+y
map <C-p> "+P

" -- Move lines
"nnoremap <A-k> :m .-2<CR>== " Move line up
"nnoremap <A-j> :m .+1<CR>== " Move line down

noremap <c-s-down> ddp
noremap <c-s-up> :call feedkeys( line('.')==1 ? '' : 'ddkP' )<CR>

" -- Panes
nnoremap vs :vs<CR>
nnoremap sp :sp<CR>
nnoremap <C-H> <C-W><C-H> " Move to left pane "ctrl-h"
nnoremap <C-L> <C-W><C-L> " Move to right pane "ctrl-l"

