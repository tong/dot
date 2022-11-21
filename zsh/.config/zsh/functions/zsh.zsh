
# By default, Ctrl+d will not close your shell if the command line is filled, this fixes it
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

zshreload () {
    exec "${SHELL}" "$@"
}

zshstats() {
    local num=${1:-50}
    fc -l 1 \
        | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
        | grep -v "./" | sort -nr | head -n $num | column -c3 -s " " -t | nl
}

