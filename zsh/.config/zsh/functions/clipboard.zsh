# Pipe stdin to clipboard
# Usage: <command> | copy
copy() {
    wl-copy
}

# Paste from clipboard to stdout
# Usage: paste > file
paste() {
    wl-paste
}
