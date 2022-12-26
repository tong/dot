mailbox_count() {
    find "$HOME/.local/share/mail/$EMAIL/$1/cur" -type f | wc -l
}
alias mail_count_archive='mailbox_count Archive'
alias mail_count_drafts='mailbox_count Drafts'
alias mail_count_inbox='mailbox_count INBOX'
alias mail_count_junk='mailbox_count Junk'
alias mail_count_sent='mailbox_count Sent'
alias mail_count_trash='mailbox_count Trash'

