Plug 'mhinz/vim-startify'

"let g:startify_custom_header = 'TTTTT'

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]


"function! GetUniqueSessionName()
"  let path = fnamemodify(getcwd(), ':~:t')
"  let path = empty(path) ? 'no-project' : path
"  let branch = gitbranch#name()
"  let branch = empty(branch) ? '' : '-' . branch
"  return substitute(path . branch, '/', '-', 'g')
"endfunction
"autocmd User        StartifyReady silent execute 'SLoad '  . GetUniqueSessionName()
"autocmd VimLeavePre *             silent execute 'SSave! ' . GetUniqueSessionName()


"let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")
"let g:startify_custom_header = (split(system('echo 23'), '\n'))
let g:startify_custom_header = split('','\n')

