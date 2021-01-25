# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

### FTL

GITHUB_USER=tong

export EDITOR='vscode'
export FILEMANAGER='nautilus'
export TERMINAL='tilix'

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

### --------------------

export ZSH=/home/tong/.oh-my-zsh

if [[ -o login ]]; then
    ZSH_THEME="zeit"
else
    ZSH_THEME="void"
    #ZSH_THEME="robbyrussell"
    #ZSH_THEME="powerlevel10k/powerlevel10k"
    #ZSH_THEME="powerlevel9k/powerlevel9k"
fi

CASE_SENSITIVE="true"
# ZSH_CUSTOM=/path/to/new-custom-folder
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
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
    git
    #git-prompt
    #haxe
    #haxelib
    history
    #neko
    nmap
    zsh-autosuggestions
    #zsh-navigation-tools
    zsh_reload
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases

### --------------------

export DEV=$HOME/dev

if [ -d "$HOME/bin" ];
    then PATH="$HOME/bin:$PATH"
fi

## Android
#export ANDROID_SDK_ROOT=$HOME/sdk/android-sdk
#export ANDROID_HOME=$HOME/sdk/android-sdk

## Armory3D
export ARMORY_SDK=$HOME/sdk/armsdk
export ARMSDK=$HOME/sdk/armsdk

## CC/C++
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

## Cuda
#PATH=$PATH:/opt/cuda/bin
#export CUDA_PATH=/opt/cuda
#export LD_LIBRARY_PATH=/opt/cuda/lib64/

PATH="$PATH:$DEV_PATH/.bin"

## Emscripten
#source $HOME/sdk/emsdk/emsdk_env.sh
#export EMSCRIPTEN=/home/tong/sdk/emsdk/upstream/emscripten

## Golang
export GOPATH=$HOME/.go
PATH="$PATH:$HOME/.go/bin"

## Haxe
export HAXELIB_PATH=$HOME/src/haxelib

## Hetzner HCloud
#source <(hcloud completion zsh)

## Java
#export JAVA_HOME=$HOME/sdk/jdk1.8.0_91
#export JAVA_HOME=/opt/jdk1.8.0_91

## Nodejs/NPM
PATH=$HOME/src/npm-global/bin:$PATH

## NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

## Om
export OM_PATH=$DEV_PATH/lib/om
export OM=$DEV/lib/om

## Opam
#. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
#. /home/tong/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

## Wasmer
#export WASMER_DIR="$HOME/.wasmer"
#[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"  # This loads wasmer

## XXX
export XXX_PATH=$DEV/tool/xxx

##### ------- Applications/Services

## Bat
#export BAT_THEME="Monokai"

##
export FZF_BASE=/usr/share/fzf
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

## GTRL
#export GTRL_PATH=$DEV_PATH/pro/gtrl/gtrl-service

#$HOME/.screenlayout/2-monitor.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
