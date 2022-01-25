
export SCREEN1=DP-2
export SCREEN2=DP-5
export SCREENSHOTS=$HOME/img/screenshots

export TERMINAL='alacritty'
export EDITOR='vim'
export VISUAL='code'
export FILEMANAGER='ranger'

#if [[ -n $SSH_CONNECTION ]]; then
#    export EDITOR='atom'
#else
#    export EDITOR='nano'
#fi

### --------------------

export ZSH=/home/tong/.oh-my-zsh

if [[ -o login ]]; then
    ZSH_THEME="void"
else
    # ZSH_THEME="random"
    ZSH_THEME="void"
fi

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
#    git
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
source /usr/share/fzf/key-bindings.zsh
#source $HOME/.scripts/fzf.sh


if [ -d "$HOME/bin" ];
    then PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.scripts" ];
	then PATH="$HOME/.scripts:$PATH"
fi
if [ -d "$HOME/.local/bin" ];
	then PATH="$HOME/.local/bin:$PATH"
fi

GITHUB_USER=tong

# Man pages colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# export ARMSDK=$HOME/dev/armory3d/armsdk.repo
# export PATH="$HOME/sdk/depot_tools:$PATH"
#export ANDROID_SDK_ROOT=$HOME/sdk/android-sdk
#export BAT_THEME="Monokai"
#export CUDA_PATH=/opt/cuda
#export EMSCRIPTEN=/home/tong/sdk/emsdk/upstream/emscripten
#export JAVA_HOME=/opt/jdk1.8.0_91
#export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
#export JAVA_HOME=$HOME/sdk/jdk1.8.0_91
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
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/src/v8/v8/out/linux:$PATH"
export VOID=$DEV/proto/void2

# if [ -d "$ANDROID_HOME/platform-tools" ] ; then
#     export PATH="$ANDROID_HOME/platform-tools:$PATH"
# fi


PATH="$PATH:$DEV_PATH/.bin"
PATH="$PATH:$HOME/.go/bin"
PATH=$HOME/src/npm-global/bin:$PATH

#source $HOME/sdk/emsdk/emsdk_env.sh

## Ranger
# if [ -n "$RANGER_LEVEL" ]; then export PS1="[ranger]$PS1"; fi

## Opam
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
#. /home/tong/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#export WASMER_DIR="$HOME/.wasmer"
#[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"  # This loads wasmer

##### ------- Applications/Services

export FZF_BASE=/usr/share/fzf
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# export WASMTIME_HOME="$HOME/.wasmtime"
# export PATH="$WASMTIME_HOME/bin:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

## Tilix (https://gnunn1.github.io/tilix-web/manual/vteconfig/)
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi
