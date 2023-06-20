zcompletions() {
    for command completion in ${(kv)_comps:#-*(-|-,*)}
    do
        printf "%-32s %s\n" $command $completion
    done | sort
}

zreload () {
    exec "${SHELL}" "$@"
}

zstats() {
    local n=50
    [ -n "$1" ] && n="$1"
    local num=${1:-$n}
    fc -l 1 \
        | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
        | grep -v "./" | sort -nr | head -n $num | column -c3 -s " " -t | nl
}

# Measure shell load time
ztime() {
	sh=${1-$SHELL}
	for i in $(seq 1 10); do time $sh -i -c exit; done
}

