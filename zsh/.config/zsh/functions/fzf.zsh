
fzf-chrome-history() {
    local cols sep browser_path open
    cols=$(( COLUMNS / 3 ))
    sep='{::}'
    p="$BROWSER"
    [ "$BROWSER" = "brave" ] && p="BraveSoftware/Brave-Browser"
    browser_path="$HOME/.config/$p/Default/History"
    cp -f "$browser_path" /tmp/h
    sqlite3 -separator $sep /tmp/h \
        "select substr(title, 1, $cols), url from urls order by last_visit_time desc" |
        awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
        fzf --prompt=" " --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs xdg-open > /dev/null 2> /dev/null
}

fzf-git-log() {
    log=$(git log --graph --color=always --format="%C(auto)%h%d %s %C(red)%C(bold)%an %C(black)%cr - %cD" "$@")
    if (( $? )) ; then
        return 1
    fi
    echo $log | fzf --prompt=" " --height 80% --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --bind "ctrl-m:execute:(grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF {} FZF-EOF"
}

fzf-man() {
    f=$(fd . $MANPATH/man${1:-1} -t f -x echo {/.} | fzf) && man $f
}

fzf-tmux() {
    if [[ ! -n $TMUX ]]; then
        ID="`tmux list-sessions`"
        if [[ -z "$ID" ]]; then
            tmux new-session
        fi
        create_new_session="Create New Session"
        ID="$ID\n${create_new_session}:"
        ID="`echo $ID | fzf | cut -d: -f1`"
        if [[ "$ID" = "${create_new_session}" ]]; then
            tmux new-session
        elif [[ -n "$ID" ]]; then
            printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
            tmux attach-session -t "$ID"
        else
            :  # Start terminal normally
        fi
    fi
}

fzf-pass() {
    HEADER="Selected password will be copied to clipboard"
    [ "$1" = "show" ] && HEADER="Selected password will be printed to stdout"
    id=$(find ~/.password-store -type f | while read PW; do echo "${PW%.*}" | cut -d'/' -f5-6; done | fzf --prompt="󱅞 " --pointer="" --border=double --header="$HEADER" --color='dark,fg+:red')
    pw=$(pass "$id")
    [ -z "$pw" ] && return 1
    if [ "$1" = "show" ]; then
        echo "$pw"
    else
        echo "$pw" | kitty +kitten clipboard
        echo "Copied to clipboard"
    fi
}

fzf-pdf() {
    result=$(find -type f -name '*.pdf' | fzf --bind "ctrl-r:reload(find -type f -name '*.pdf')" --preview "pdftotext {} - | less")
    [ -n "$result" ] && zathura "$result" &
}

