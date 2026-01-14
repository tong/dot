ZDOTDIR="$XDG_CONFIG_HOME/zsh"

HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase

setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_find_no_dups extended_history hist_expire_dups_first \
       hist_ignore_dups hist_verify
setopt interactive_comments
setopt noflowcontrol
setopt auto_cd auto_pushd pushd_ignore_dups pushd_silent cdable_vars
setopt correct extended_glob

# function zvm_after_init() {
  # source /usr/share/fzf/completion.zsh
  # source /usr/share/fzf/key-bindings.zsh
  # ZVM_CURSOR_STYLE_ENABLED=true
  # ZVM_INSERT_MODE_CURSOR=$'\e[6 q'   # blinking beam
  # ZVM_NORMAL_MODE_CURSOR=$'\e[2 q'   # blinking block
# }

#source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

source "$ZDOTDIR/plugins/zsh-completions/zsh-completions.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "$ZDOTDIR/completion.zsh"

for f in "$ZDOTDIR/functions/"*.zsh; do source "$f"; done
for f in "$ZDOTDIR/aliases/"*.zsh;   do source "$f"; done

source "$ZDOTDIR/bindings.zsh"
#source "$ZDOTDIR/config/man.zsh"
#source "$ZDOTDIR/config/ssh.zsh"

################################################################################

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# FZF setup is handled in `zvm_after_init` for compatibility with zsh-vi-mode.
eval "$(fzf --zsh)"
# eval "$(atuin init zsh)"
# eval "$(luarocks path --bin)"

################################################################################

for p in "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.luarocks/bin" "$HOME/.node_modules/bin" "$GOPATH/bin"; do
  [ -d "$p" ] && PATH="$p:$PATH"
done

# [[ ! -r /home/tong/.opam/opam-init/init.zsh ]] || source /home/tong/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

################################################################################

################################################################################

export FZF_CTRL_R_OPTS="--prompt=' ' --preview 'echo {}' --preview-window=down:3:wrap"
export FZF_CTRL_T_OPTS="--prompt=' ' --preview 'bat --style=numbers --color=always {}' --preview-window=right:50%"

export LD_LIBRARY_PATH=/usr/local/lib

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export GOPATH="$HOME/.go"
export PICO_SDK_PATH="$HOME/sdk/pico-sdk"
export HAXELIB_PATH=$HOME/.haxe
export HAXE_STD_PATH=/usr/local/share/haxe/std
export HAXE_STD_PATH=/usr/share/haxe/std
export HASHLINK=$HOME/src/hashlink
export THEME=gruvbox

# export ARMSDK=$HOME/armory/armsdk
# export ARMORY_PLAY_KROM='$ARMSDK/Krom/Krom $path $resources --consolepid $pid'
# export ARMORY_PLAY_HTML5='chromium --app=$url --new-window --window-size=$width,$height --auto-open-devtools-for-tabs'

# export ANDROID_NDK_HOME=/home/tong/sdk/android-ndk
# export PATH=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin:${PATH}
# export ANDROID_SYSROOT=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot
# export ANDROID_TOOLCHAIN=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64
# export ANDROID_API=21
# export ANDROID_HOME=${HOME}/sdk/android-sdk

#export ZEPHYR_SDK_INSTALL_DIR=/home/tong/sdk/zephyr-sdk-0.16.5-1

