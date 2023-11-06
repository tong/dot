mailbox_count() {
    find "$HOME/.local/share/mail/$EMAIL/$1" -type f | wc -l
}
alias mail_count_archive='mailbox_count Archive/cur'
alias mail_count_drafts='mailbox_count Drafts/cur'
alias mail_count_inbox='mailbox_count INBOX/cur'
alias mail_count_junk='mailbox_count spambucket/new'
alias mail_count_sent='mailbox_count Sent/cur'
alias mail_count_trash='mailbox_count Trash/cur'

