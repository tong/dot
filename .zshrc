GITHUB_USER=$USER

export TERMINAL='alacritty'
export EDITOR='nvim'
export VISUAL='neovide'
export FILEMANAGER='ranger'

export SCREEN1=DP-2
export SCREEN2=DP-5

export SCREENSHOTS=$HOME/img/screenshots

#export ARMSDK=$HOME/dev/armory3d/armsdk.repo
#export PATH="$HOME/sdk/depot_tools:$PATH"
#export ANDROID_SDK_ROOT=$HOME/sdk/android-sdk
#export BAT_THEME="Monokai"
#export CUDA_PATH=/opt/cuda
#export EMSCRIPTEN=/home/tong/sdk/emsdk/upstream/emscripten
#export LD_LIBRARY_PATH=/opt/cuda/lib64/
export ANDROID_HOME=$HOME/sdk/android-sdk
export ARMSDK=$HOME/dev/armory3d/armsdk
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export DEV=$HOME/dev
export EMSDK=$HOME/sdk/emsdk
export GOPATH=$HOME/.go
export HAXELIB_PATH=$HOME/src/haxelib
export OM=$DEV/lib/om
export VOID=$DEV/proto/void2
export ZSH=/home/tong/.oh-my-zsh

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/src/v8/v8/out/linux:$PATH"

if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH" fi
if [ -d "$HOME/.scripts" ]; then PATH="$HOME/.scripts:$PATH" fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH" fi

# PATH="$PATH:$HOME/.go/bin"
PATH=$HOME/src/npm-global/bin:$PATH

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

# Man pages colors
# export LESS_TERMCAP_mb=$'\e[1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'

# . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#export WASMER_DIR="$HOME/.wasmer"
#[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"  # This loads wasmer

export FZF_BASE=/usr/share/fzf
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if [ -n "$RANGER_LEVEL" ]; then
    export PS1="[ranger]$PS1";
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then # https://gnunn1.github.io/tilix-web/manual/vteconfig/
    source /etc/profile.d/vte.sh
fi
