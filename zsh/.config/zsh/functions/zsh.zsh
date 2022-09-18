zshstats() {
    local num=${1:-50}
    fc -l 1 \
        | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
        | grep -v "./" | sort -nr | head -n $num | column -c3 -s " " -t | nl
}

zshreload () {
    exec "${SHELL}" "$@"
}
