# shellcheck shell=zsh
#
# Function to count files in a given mailbox directory.
# Usage: mailbox_count <mailbox_subdirectory>
# Example: mailbox_count INBOX/cur
mailbox_count() {
    # Base directory for mail. Can be overridden by setting MAIL_DIR.
    local mail_base_dir="${MAIL_DIR:-$HOME/.local/share/mail}"
    # Check if EMAIL variable is set.
    if [[ -z "$EMAIL" ]]; then
        echo "Error: EMAIL environment variable is not set." >&2
        return 1
    fi
    local mailbox_path="$mail_base_dir/$EMAIL/$1"
    if [[ ! -d "$mailbox_path" ]]; then
        echo 0
        return
    fi
    local files
    files=($mailbox_path/*(N.)) # N: NULL_GLOB, .: regular files only
    echo ${#files}
}

local -A mailboxes
mailboxes=(
    [archive]=Archive/cur
    [drafts]=Drafts/cur
    [inbox]=INBOX/cur
    [junk]=spambucket/new
    [sent]=Sent/cur
    [trash]=Trash/cur
)

for box in "${(@k)mailboxes}"; do
    alias "mail_count_${box}"="mailbox_count ${mailboxes[$box]}"
done

unset mailboxes

