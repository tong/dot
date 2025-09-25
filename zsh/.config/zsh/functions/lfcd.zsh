# shellcheck shell=zsh
# A wrapper for the lf file manager that changes the directory on exit.
lfcd() {
    local tmp
    tmp=$(mktemp) || return 1
    # The temp file will be removed when the function exits.
    trap "rm -f -- '$tmp'" EXIT
    # Run lf, telling it to write the last directory to the temp file.
    lf -last-dir-path="$tmp" "$@"
    # If lf wrote to the temp file, read the directory path.
    if [[ -f "$tmp" ]]; then
        local dir
        dir=$(<"$tmp")
        # If it's a valid directory and not the current one, change to it.
        if [[ -d "$dir" && "$dir" != "$PWD" ]]; then
            cd -- "$dir"
        fi
    fi
}

