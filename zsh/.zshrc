HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

ZSH_THEME="void"
#if [[ -o login ]]; then
#    ZSH_THEME="lambda"
#fi
CASE_SENSITIVE="true"
# ZSH_CUSTOM=/path/to/new-custom-folder
# HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
    colorize
    extract
    #git
    #git-prompt
    #haxe
    #haxelib
    history
    #neko
    #nmap
    taskwarrior
    # thefuck
    zsh-autosuggestions
    #zsh-navigation-tools
    #zsh_reload
    zsh-syntax-highlighting
)

source $HOME/.env

source $ZSH/oh-my-zsh.sh

source $HOME/.config/lf/script/icons
source $HOME/.config/zsh/aliases
source $HOME/.config/zsh/aliases_user

source /usr/share/fzf/key-bindings.zsh

eval "$(zoxide init zsh)"

if [ -n "$RANGER_LEVEL" ]; then
    export PS1="[ranger]$PS1";
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then # https://gnunn1.github.io/tilix-web/manual/vteconfig/
    source /etc/profile.d/vte.sh
fi


lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
bindkey -s '^a' 'bc -lq\n'
#bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/sdk/qmk_firmware/util/qmk_tab_complete.sh

