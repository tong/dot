Plug 'xarthurx/taskwarrior.vim'

let g:task_rc_override = 'rc.defaultwidth=0'
"let g:task_rc_override = 'rc.defaultheight=0'

nnoremap <buffer> A       ... " add annotation
nnoremap <buffer> x       ... " delete annotation.
nnoremap <buffer> o       ... " open the annotation as a file.
nnoremap <buffer> a       ... " create new task.
nnoremap <buffer> d       ... " set the task in current line done.
nnoremap <buffer> D       ... " delete field/annotation/task
nnoremap <buffer> <Space> ... " select/remove current task to selected list
nnoremap <buffer> m       ... " modify current field.
nnoremap <buffer> M       ... " modify current task.
nnoremap <buffer> f       ... " change filter
nnoremap <buffer> r       ... " change report type
nnoremap <buffer> c       ... " execute a command for selected tasks/current task
nnoremap <buffer> R       ... " refresh the report/clear selected list
nnoremap <buffer> q       ... " quit buffer.
nnoremap <buffer> X       ... " clear all completed task.
nnoremap <buffer> p       ... " duplicate selected tasks
nnoremap <buffer> u       ... " undo last change.
nnoremap <buffer> +       ... " start task
nnoremap <buffer> -       ... " stop task
nnoremap <buffer> S       ... " sync with taskd server.
nnoremap <buffer> s       ... " sort by this column primarily.(if already of the highest priority then switch the polarity)
nnoremap <buffer> <       ... " sort by this column increasingly.(if already increasingly then increase its priority)
nnoremap <buffer> >       ... " sort by this column decreasingly.(if already decreasingly then decrease its priority)
nnoremap <buffer> H       ... " cycle column format left
nnoremap <buffer> L       ... " cycle column format right
nnoremap <buffer> J       ... " next historical entry
nnoremap <buffer> K       ... " previous historical entry
nnoremap <buffer> B       ... " create a bookmark for current combination
nnoremap <buffer> <F1>    ... " view the documents
nnoremap <buffer> <CR>    ... " show task info.
nnoremap <buffer> <TAB>   ... " jump to the next column
nnoremap <buffer> <S-TAB> ... " jump to the previous column
nnoremap <buffer> <right> ... " jump to the next non-empty column
nnoremap <buffer> <left>  ... " jump to the previous non-empty column
vnoremap <buffer> d       ... " set done to all visual selected tasks
vnoremap <buffer> D       ... " delete all visual selected tasks
vnoremap <buffer> <CR>    ... " show information about visual selected tasks
vnoremap <buffer> <Space> ... " add visual selected tasks to selected list

" default task report type
let g:task_report_name     = 'next'
" custom reports have to be listed explicitly to make them available
" let g:task_report_command  = []
" " whether the field under the cursor is highlighted
" let g:task_highlight_field = 1
" " can not make change to task data when set to 1
" let g:task_readonly        = 0
" " vim built-in term for task undo in gvim
" let g:task_gui_term        = 1
" " allows user to override task configurations. Seperated by space. Defaults
" to ''
" let g:task_rc_override     = 'rc.defaultwidth=999'
" " default fields to ask when adding a new task
" let g:task_default_prompt  = ['due', 'description']
" " whether the info window is splited vertically
" let g:task_info_vsplit     = 0
" " info window size
" let g:task_info_size       = 15
" " info window position
" let g:task_info_position   = 'belowright'
" " directory to store log files defaults to taskwarrior data.location
" let g:task_log_directory   = '~/.task'
" " max number of historical entries
" let g:task_log_max         = '20'
" " forward arrow shown on statusline
" let g:task_left_arrow      = ' <<'
" " backward arrow ...
" let g:task_left_arrow      = '>> '

"highlight default link taskwarrior_tablehead   Tabline
"highlight default link taskwarrior_field       IncSearch
"highlight default link taskwarrior_selected    Visual
"highlight default link taskwarrior_id          VarId
"highlight default link taskwarrior_project     String
"highlight default link taskwarrior_Status      Include
"highlight default link taskwarrior_priority    Class
"highlight default link taskwarrior_due         Todo
"highlight default link taskwarrior_end         Keyword
"highlight default link taskwarrior_description Normal
"highlight default link taskwarrior_entry       Special
"highlight default link taskwarrior_depends     Todo
"highlight default link taskwarrior_tags        Keyword
"highlight default link taskwarrior_uuid        VarId
"highlight default link taskwarrior_urgency     Todo

