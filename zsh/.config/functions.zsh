 
cd() {
    if (( $+2 )); then
        builtin cd "$@"
        return 0
    fi
    if [ -f "$1" ]; then
        echo "${yellow}cd ${1:h}${NC}" >&2
        builtin cd "${1:h}"
    else
        builtin cd "${@}"
    fi
}
 
reload () {
    exec "${SHELL}" "$@"
}
 
confirm() {
    local answer
    echo -ne "zsh: sure you want to run '${YELLOW}$*${NC}' [yN]? "
    read -q answer
        echo
    if [[ "${answer}" =~ ^[Yy]$ ]]; then
        command "${@}"
    else
        return 1
    fi
}

confirm_wrapper() {
    if [ "$1" = '--root' ]; then
        local as_root='true'
        shift
    fi
    local prefix=''
    if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
        prefix="sudo"
    fi
    confirm ${prefix} "$@"
}

poweroff() { confirm_wrapper --root $0 "$@"; }
reboot() { confirm_wrapper --root $0 "$@"; }
hibernate() { confirm_wrapper --root $0 "$@"; }

termtitle() {
    case "$TERM" in
        rxvt*|xterm*|nxterm|gnome|screen|screen-*|st|st-*)
            local prompt_host="${(%):-%m}"
            local prompt_user="${(%):-%n}"
            local prompt_char="${(%):-%~}"
            case "$1" in
                precmd)
                    printf '\e]0;%s@%s: %s\a' "${prompt_user}" "${prompt_host}" "${prompt_char}"
                ;;
                preexec)
                    printf '\e]0;%s [%s@%s: %s]\a' "$2" "${prompt_user}" "${prompt_host}" "${prompt_char}"
                ;;
            esac
        ;;
    esac
}

setup_git_prompt() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        unset git_prompt
        return 0
    fi
    local git_status_dirty git_status_stash git_branch
    if [ "$(git --no-optional-locks status --untracked-files='no' --porcelain)" ]; then
        git_status_dirty='%F{green}*'
    else
        unset git_status_dirty
    fi
    if [ "$(git stash list)" ]; then
        git_status_stash="%F{yellow}▲"
    else
        unset git_status_stash
    fi
    git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
    git_branch="${git_branch#refs/heads/}"
    if [ "${#git_branch}" -ge 24 ]; then
        git_branch="${git_branch:0:21}..."
    fi
    git_branch="${git_branch:-no branch}"
    git_prompt=" %F{blue}[%F{253}${git_branch}${git_status_dirty}${git_status_stash}%F{blue}]"
}

precmd() {
    # Set terminal title.
    termtitle precmd
    # Set optional git part of prompt.
    setup_git_prompt
}

preexec() {
    # Set terminal title along with current executed command pass as second argument
    termtitle preexec "${(V)1}"
}

man() {
    if command -v vimmanpager >/dev/null 2>&1; then
        PAGER="vimmanpager" command man "$@"
    else
        command man "$@"
    fi
}

lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || exit
    fi
}
