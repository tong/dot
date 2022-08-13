CURRENT_BG='NONE'
PRIMARY_FG=black

# BRANCH="\ue0a0"
# BRANCH="\ue725"
# Icons
BRANCH=""
CROSS="✖"
DETACHED="\u27a6"
GEAR=""
LIGHTNING="⚡"
PLUSMINUS="\u00b1"
SEGMENT_SEPARATOR="\ue0b0"

TASKWARRIOR_URGENT=""
TASKWARRIOR_DUETOMORROW=""
TASKWARRIOR_DUETODAY=""
TASKWARRIOR_OVERDUE=""
TASKWARRIOR_OK=""

## Begin a segment
# Takes two arguments, background and foreground.
# Both can be omitted, rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
    else
        print -n "%{$bg%}%{$fg%}"
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && print -n $3
}

prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        print -n "%{%k%}"
    fi
    print -n "%{%f%} "
    CURRENT_BG=''
}

## Context: user@hostname (who am I and where am I)
prompt_context() {
    #local user=`whoami`
    # if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    #prompt_segment $PRIMARY_FG default "  %(!.%{%F{yellow}%}.)$user@%m "
    prompt_segment $PRIMARY_FG default " %(!.%{%F{yellow}%}.) "
    # fi
}

## Git: branch/detached head, dirty status
prompt_git() {
    local color ref
    is_dirty() {
        test -n "$(git status --porcelain --ignore-submodules)"
    }
    ref="$vcs_info_msg_0_"
    if [[ -n "$ref" ]]; then
        if is_dirty; then
            color=yellow
            ref="${ref} $PLUSMINUS"
        else
            color=green
            ref="${ref} "
        fi
        if [[ "${ref/.../}" == "$ref" ]]; then
            ref="$BRANCH $ref"
        else
            ref="$DETACHED ${ref/.../}"
        fi
        prompt_segment $color $PRIMARY_FG
        print -Pn " $ref"
    fi
}

prompt_time() {
    #prompt_segment white black "$(date +%R:%S)"
    prompt_segment white black "$(date +%H%M)"
}

prompt_virtualenv() {
    local virtualenv_path="$VIRTUAL_ENV"
    if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        prompt_segment blue black "(`basename $virtualenv_path`)"
    fi
}

prompt_dir() {
    case "$PWD" in
        #$HOME/bin*)
            #prompt_segment blue $PRIMARY_FG '  %~'
        #;;
        #$HOME/dev*)
            #prompt_segment black grey '  %~'
        #;;
        #$HOME/doc*)
            #prompt_segment blue $PRIMARY_FG ' ◆ %~'
        #;;
        #$HOME/img*)
            #prompt_segment blue $PRIMARY_FG '  %~'
        #;;
        *)
            #prompt_segment white black '%~'
            prompt_segment blue $PRIMARY_FG ' %~ '
        ;;
    esac
}

prompt_history() {
    local hist_no="${blue_op}%h${blue_cp}"
    prompt_segment black grey "$hist_no"
}

## Status:
# - was there an error
# - am i root
# - are there background jobs?
prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR"
    [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG default " $symbols "
}

prompt_taskwarrior() {
    if [ `task +READY +OVERDUE count` -gt "0" ]  ; then
        printf "%b" "\u$TASKWARRIOR_OVERDUE "
    elif [ `task +READY +DUETODAY count` -gt "0" ]  ; then
        printf "%b" "\u$TASKWARRIOR_DUETODAY "
    elif [ `task +READY +DUETomorrow count` -gt "0" ]  ; then
        printf "%b" "\u$TASKWARRIOR_DUETOMORROW "
    elif [ `task +READY urgency \> 10 count` -gt "0" ]  ; then
        printf "%b" "\u$TASKWARRIOR_URGENT "
    else
        printf "%b" "\u$OK"
    fi
}

prompt_void_main() {
    RETVAL=$?
    CURRENT_BG='NONE'
    #prompt_time
    prompt_virtualenv
    #prompt_history
    prompt_status
    #prompt_taskwarrior
    prompt_context
    prompt_dir
    prompt_git
    prompt_end
}

prompt_void_precmd() {
    vcs_info
    PROMPT='%{%f%b%k%}$(prompt_void_main)'
}

prompt_void_setup() {
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info
    prompt_opts=(cr subst percent)
    add-zsh-hook precmd prompt_void_precmd
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' check-for-changes false
    zstyle ':vcs_info:git*' formats '%b'
    zstyle ':vcs_info:git*' actionformats '%b (%a)'
}
prompt_void_setup "$@"
#RPROMPT="$(date +%R:%S)"
 
