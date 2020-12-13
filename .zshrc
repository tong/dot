export ZSH=/home/tong/.oh-my-zsh

if [[ -o login ]]; then
    ZSH_THEME="zeit"
else
    #ZSH_THEME="zeit"
    ZSH_THEME="void"
    #ZSH_THEME="powerlevel9k/powerlevel9k"
fi

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#plugins=(adb colorize extract git github hashlink haxe haxelib history neko ng nmap python rust zsh-autosuggestions zsh_reload)
#plugins=(adb colorize extract git github history ng nmap python rust zsh-autosuggestions zsh_reload)
plugins=(
    colorize
    extract
    git
    history
    zsh-autosuggestions
    zsh_reload
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases

################################################################################

# Man pages colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

#if [[ -n $SSH_CONNECTION ]]; then
#    export EDITOR='atom'
#else
#    export EDITOR='nano'
#fi

export EDITOR='vscode'
export FILEMANAGER='nautilus'
export TERMINAL='tilix'

#export ELECTRON_TRASH=gio

##
export FZF_BASE=/usr/share/fzf
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

##
PATH="$PATH:$HOME/bin"

##### --- Development

## Armory3D
export ARMORY_SDK=$HOME/sdk/armsdk
export ARMSDK=$HOME/sdk/armsdk

## Github
GITHUB_USER=tong
#GITHUB_PASSWORD=

## Path to dev directory
export DEV=$HOME/dev

## Dev Tools
PATH="$PATH:$DEV_PATH/.bin"

## XXX
export XXX_PATH=$DEV/tool/xxx

## hxArduino
export ARDUINO_HOME=$HOME/sdk/arduino

## GTRL
export GTRL_PATH=$DEV_PATH/pro/gtrl/gtrl-service

## Haarp
#export HAARP_APP=$DEV/pro/weownthenite/haarp
#export HAARP_RES=/mnt/HD1/HAARP

## Android
#export ANDROID_SDK_ROOT=$HOME/sdk/android-sdk
#export ANDROID_HOME=$HOME/sdk/android-sdk

## Bat
#export BAT_THEME="Monokai"

## CC/C++
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

## Cuda
#PATH=$PATH:/opt/cuda/bin
#export CUDA_PATH=/opt/cuda
#export LD_LIBRARY_PATH=/opt/cuda/lib64/

## Emscripten
#source $HOME/sdk/emsdk/emsdk_env.sh
#export EMSCRIPTEN=/home/tong/sdk/emsdk/upstream/emscripten

## Golang
export GOPATH=$HOME/.go

## Haxe
export HAXELIB_PATH=$HOME/src/haxelib

## Hetzner HCloud
#source <(hcloud completion zsh)

## Java
#export JAVA_HOME=$HOME/sdk/jdk1.8.0_91
#export JAVA_HOME=/opt/jdk1.8.0_91

## Nodejs/NPM
PATH=$HOME/src/npm-global/bin:$PATH

## Om
export OM_PATH=$DEV_PATH/lib/om
export OM=$DEV/lib/om

## Opam
#. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
#. /home/tong/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

## Ruby
#PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin"

## Tron
#export TRON=$HOME/dev/lib/tron
#PATH="$PATH:$TRON/bin"

## Wasmer
#export WASMER_DIR="$HOME/.wasmer"
#[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"  # This loads wasmer

## NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

$HOME/.screenlayout/2-monitor.sh
