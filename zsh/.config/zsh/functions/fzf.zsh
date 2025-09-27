fzf-chrome-bookmarks() {
    p="$BROWSER"
    [ "$BROWSER" = "brave" ] && p="BraveSoftware/Brave-Browser"
    bookmarks_path="$HOME/.config/$p/Default/Bookmarks"
    jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'
    jq -r "$jq_script" < "$bookmarks_path" \
        | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
        | fzf --prompt=" " --ansi \
        | cut -d$'\t' -f2 \
        | xargs xdg-open
}

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

fzf-clipboard() {
    local sel decoded
    sel=$(cliphist list | fzf --prompt "󰅇 " --no-sort) || return
    decoded=$(cliphist decode <<<"$sel")
    printf '%s\n' "$decoded" | wl-copy
    print -r -- "$decoded"
    # notify-send --app-name="clipboard" "$icon copied to clipboard"
}

fzf-git-log() {
    log=$(git log --graph --color=always --format="%C(auto)%h%d %s %C(red)%C(bold)%an %C(black)%cr - %cD" "$@")
    if (( $? )) ; then
        return 1
    fi
    echo "$log" | fzf --prompt=" " --height 80% --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --bind "ctrl-m:execute:(grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF' {} FZF-EOF"
}

fzf-man() {
    man -k . | fzf -q "$1" --prompt='󰋖 '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

fzf-nerdfont() {
  local selected icon nerdfont_map
  nerdfont_map="$HOME/.local/share/nerdfont.map"
  if [[ ! -f "$nerdfont_map" ]]; then
    echo "fzf-nerdfont: Map file not found at $nerdfont_map" >&2
    return 1
  fi
  selected=$(cat "$nerdfont_map" | fzf --prompt=" ")
  # Exit if fzf was cancelled
  [[ -z "$selected" ]] && return 0
  icon="${selected:0:1}"
  # Echo the icon to the terminal
  echo "$icon"
  # Copy to clipboard using wl-copy or xclip
  if command -v wl-copy >/dev/null; then
      printf "%s" "$icon" | wl-copy
  elif command -v xclip >/dev/null; then
      printf "%s" "$icon" | xclip -selection clipboard
  else
      echo "fzf-nerdfont: Please install wl-copy or xclip to use clipboard functionality." >&2
  fi
  notify-send --app-name="nerdfont" "$icon copied to clipboard"
}

fzf-pass() {
    local header id
    header="Selected password will be copied to clipboard"
    [ "$1" = "show" ] && header="Selected password will be printed to stdout"
    id=$(find "${PASSWORD_STORE_DIR:-$HOME/.password-store}" -type f -name '*.gpg' -printf '%P\n' |
        sed 's/\.gpg$//' |
        fzf --prompt="󱅞 " --pointer="" --border=double --header="$header" --color='dark,fg+:red')
    [[ -z "$id" ]] && return 0
    if [ "$1" = "show" ]; then
        pass "$id"
    else
        pass -c "$id"
        notify-send --app-name="pass" "Password for '$id' copied to clipboard"
    fi
}

fzf-pdf() {
    local result
    result=$(find . -type f -iname '*.pdf' | fzf --prompt=" " --bind "ctrl-r:reload(find . -type f -iname '*.pdf')" --preview "pdftotext {} - | less")
    if [[ -n "$result" ]]; then
        xdg-open "$result" >/dev/null 2>&1 &
    fi
}

fzf-tmux() {
    if [[ -n "$TMUX" ]]; then
        return 0
    fi
    local sessions choice create_new="Create New Session"
    sessions=$(tmux list-sessions -F '#S' 2>/dev/null)
    choice=$(printf "%s\n%s" "$sessions" "$create_new" | fzf --prompt=" " --border=double)
    if [[ -z "$choice" ]]; then
        return 0
    elif [[ "$choice" = "$create_new" ]]; then
        tmux new-session
    else
        printf '\033]777;tabbedx;set_tab_name;%s\007' "$choice"
        tmux attach-session -t "$choice"
    fi
}

fzf-task() {
    local tasks
    tasks=$(task +PENDING list | sed '1,3d' | head -n -1)
    if [[ -z "$tasks" ]]; then
        echo "No pending tasks."
        return
    fi
    local selected_lines
    selected_lines=$(echo "$tasks" | fzf --height 60% --ansi --multi --reverse --prompt=" Task> " --header="Select tasks to add their IDs to the command line." --preview="task info {1}")
    if [[ -z "$selected_lines" ]]; then
        return 0
    fi
    local ids
    ids=$(echo "$selected_lines" | awk '{print $1}' | tr '\n' ' ')
    print -z "task ${ids}"
}
