mailbox_count() {
    find "$HOME/.local/share/mail/$EMAIL/$1/cur" -type f | wc -l
}
alias mail_count_archive='count_mailbox Archive'
alias mail_count_drafts='count_mailbox Drafts'
alias mail_count_inbox='count_mailbox INBOX'
alias mail_count_junk='count_mailbox Junk'
alias mail_count_sent='count_mailbox Sent'
alias mail_count_trash='count_mailbox Trash'

