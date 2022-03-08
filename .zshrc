ZSH_THEME="void"
# if [[ -o login ]]; then
#     ZSH_THEME="void"
# fi
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
    zsh_reload
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source $HOME/.zsh_aliases
source $HOME/.zsh_aliases_user

#source $HOME/.scripts/fzf.sh
source /usr/share/fzf/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -n "$RANGER_LEVEL" ]; then
    export PS1="[ranger]$PS1";
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then # https://gnunn1.github.io/tilix-web/manual/vteconfig/
    source /etc/profile.d/vte.sh
fi

source ~/.env
