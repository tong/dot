CURRENT_BG='NONE'
PRIMARY_FG=black

SEGMENT_SEPARATOR=""
#SEGMENT_SEPARATOR=""

BRANCH=""
CIRCLE=""
CROSS=""
DETACHED="\u27a6"
GEAR=""
LIGHTNING="⚡"
PLUSMINUS="\u00b1"

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

prompt_status() {
    local symbols
    symbols=()
    #[[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
    if [[ $RETVAL -ne 0 ]]; then
        #symbols+="%{%K{black}%F{foreground}%}$CROSS"
        symbols+="$CROSS"
        if [[ $RETVAL -ne 130 ]]; then
            symbols+="$RETVAL"
        fi
    else
        symbols+="$CIRCLE"
    fi
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR"
    [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG white "$symbols"
}

prompt_context() {
    #local seg=""
    local seg
    seg=()
    #seg+=$CIRCLE
    #local seg=""
    #local user=`whoami`
    # if [[ "$user" != "$DEFAULT_USER" ]]; then
    #     seg="$user@%m"
    # else
    #     seg="  "
    # fi
    sshcon=$SSH_CONNECTION
    if (( ${+sshcon} )); then
        seg+=" $(cut -d' ' -f 1 <<< $sshcon)"
    fi

    # if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    #prompt_segment $PRIMARY_FG default "  %(!.%{%F{yellow}%}.)$user@%m "
    #prompt_segment $PRIMARY_FG default "  %(!.%{%F{red}%}.)"
    #prompt_segment white black "  %(!.%{%F{red}%}.)"
    #prompt_segment black white "  %(!.%{%F{red}%}.)"
    #SEGMENT_SEPARATOR=""
    prompt_segment black white "$seg" 
}

#source $ZDOTDIR/plugins/gitstatus/gitstatus.plugin.zsh
function prompt_gitstatus() {
    local SEG
    SEG=()
    if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
        # SEG="${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}"  # escape %
        SEG+=$VCS_STATUS_LOCAL_BRANCH
        (( VCS_STATUS_NUM_STAGED    )) && SEG+="+$VCS_STATUS_NUM_STAGED"
        (( VCS_STATUS_NUM_UNSTAGED  )) && SEG+="!$VCS_STATUS_NUM_UNSTAGED"
        (( VCS_STATUS_NUM_UNTRACKED )) && SEG+="?$VCS_STATUS_NUM_UNTRACKED"
        [[ VCS_STATUS_TAG ]] && SEG+="$VCS_STATUS_TAG"
       
        color=white
        if [[ $VCS_STATUS_HAS_CONFLICTED -ne 0 ]]; then
            color=red
        elif [[ $VCS_STATUS_HAS_UNSTAGED -ne 0 ]]; then
            color=yellow
        elif [[ $VCS_STATUS_HAS_STAGED -ne 0 ]]; then
            color=magenta
        elif [[ $VCS_STATUS_HAS_UNTRACKED -ne 0 ]]; then
            color=cyan
        else
            color=green
        fi

        prompt_segment $color black " $SEG "
        
        ##SEGMENT_SEPARATOR=""
        #[[ $VCS_STATUS_TAG ]] && prompt_segment white black " $VCS_STATUS_TAG "
  fi
  #setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}
# gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
# autoload -Uz add-zsh-hook
# add-zsh-hook precmd prompt_gitstatus


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
        $HOME/img*) prompt_segment blue $PRIMARY_FG '   %~' ;;
        $HOME/.config*) prompt_segment cyan black '  %~ ' ;;
        #*) prompt_segment blue $PRIMARY_FG ' %~ '
        *) prompt_segment white black ' %~ '
        ;;
    esac
    #[[ -f "package.json" ]] && prompt_segment red white '   '
}

prompt_history() {
    local hist="${blue_op}%h${blue_cp}"
    prompt_segment black grey "$hist"
}

prompt_tasks() {
    prompt_segment red $PRIMARY_FG
    if [ `task +READY +OVERDUE count` -gt "0" ]; then
        printf "%b" "\u$TASKWARRIOR_OVERDUE "
    elif [ `task +READY +DUETODAY count` -gt "0" ]; then
        printf "%b" "\u$TASKWARRIOR_DUETODAY "
    elif [ `task +READY +DUETomorrow count` -gt "0" ]; then
        printf "%b" "\u$TASKWARRIOR_DUETOMORROW "
    elif [ `task +READY urgency \> 10 count` -gt "0" ]; then
        printf "%b" "\u$TASKWARRIOR_URGENT "
    else
        printf "%b" "\u$OK"
    fi
}

prompt_void_main() {
    RETVAL=$?
    CURRENT_BG='NONE'
    prompt_virtualenv
    #prompt_history
    prompt_status
    #prompt_tasks
    prompt_context
    prompt_dir
    prompt_git
    #prompt_gitstatus
    #prompt_time
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
    #zstyle ':vcs_info:*' check-for-changes false
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:git*' formats '%b'
    zstyle ':vcs_info:git*' actionformats '%b (%a)'
}
prompt_void_setup "$@"

#PROMPT='%{%f%b%k%}$(prompt_void_main)'

# prompt_void_setup() {
#
#     gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
#     autoload -Uz add-zsh-hook
#     add-zsh-hook precmd prompt_gitstatus
#
#     PROMPT='%{%f%b%k%}$(prompt_void_main)'
#
#     # autoload -Uz add-zsh-hook
#     # autoload -Uz vcs_info
#     # prompt_opts=(cr subst percent)
#     # add-zsh-hook precmd prompt_void_precmd
#     # zstyle ':vcs_info:*' enable git
#     # zstyle ':vcs_info:*' check-for-changes true
#     # zstyle ':vcs_info:git*' formats '%b'
#     # zstyle ':vcs_info:git*' actionformats '%b (%a)'
# }

#gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
#autoload -Uz add-zsh-hook
# add-zsh-hook precmd prompt_gitstatus

#RPROMPT="$(date +%R:%S)"

