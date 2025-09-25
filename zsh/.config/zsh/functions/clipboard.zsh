# shellcheck shell=zsh
clipboard() {
  local sel decoded
  sel=$(cliphist list | fzf --prompt "󰅇 " --no-sort) || return
  decoded=$(cliphist decode <<<"$sel")
  printf '%s\n' "$decoded" | wl-copy
  print -r -- "$decoded"
}

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
