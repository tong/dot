
# Use comments in interactive shell
setopt interactive_comments
# Disable flow control (Ctrl-S/Ctrl-Q)
setopt noflowcontrol

setopt AUTO_CD              # Go to folder path without using cd.
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt CORRECT              # Spelling correction
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# --- History
HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.

# ------------------------------------------------------------------------------
# Environment Variables & PATH
# ------------------------------------------------------------------------------

# export LESS_TERMCAP_mb=$'\e[1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export GOPATH="$HOME/.go"
export HAXELIB_PATH=$HOME/.haxelib
export HAXE_STD_PATH=/usr/local/share/haxe/std
export HASHLINK=$HOME/src/hashlink
export THEME=gruvbox

[ -d "$HOME/.local/bin" ]      && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.cargo/bin" ]      && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.luarocks/bin" ]   && PATH="$HOME/.luarocks/bin:$PATH"
[ -d "$HOME/.npm-global/bin" ] && PATH="$HOME/.npm-global/bin:$PATH"
[ -d "$GOPATH/bin" ]           && PATH="$GOPATH/bin:$PATH"

# ------------------------------------------------------------------------------
# Completions, Functions & Aliases
# ------------------------------------------------------------------------------

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

source "$ZDOTDIR/completion.zsh"

source "$ZDOTDIR/functions/archive.zsh"
source "$ZDOTDIR/functions/autosource.zsh"
source "$ZDOTDIR/functions/clipboard.zsh"
source "$ZDOTDIR/functions/confirm.zsh"
source "$ZDOTDIR/functions/fzf.zsh"
source "$ZDOTDIR/functions/gitignore.zsh"
source "$ZDOTDIR/functions/img.zsh"
source "$ZDOTDIR/functions/lfcd.zsh"
source "$ZDOTDIR/functions/mail.zsh"
source "$ZDOTDIR/functions/take.zsh"
source "$ZDOTDIR/functions/zsh.zsh"

source "$ZDOTDIR/aliases/core.zsh"
source "$ZDOTDIR/aliases/git.zsh"
source "$ZDOTDIR/aliases/nmap.zsh"
source "$ZDOTDIR/aliases/tmux.zsh"
source "$ZDOTDIR/aliases/user.zsh"

# ------------------------------------------------------------------------------
# Plugins
# ------------------------------------------------------------------------------

# --- zsh-vi-mode ---
# Must be sourced before other plugins that affect keybindings.
function zvm_config() {
    # ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    # ZVM_VI_ESCAPE_BINDKEY=jj
}
# Load fzf after zsh-vi-mode is initialized to prevent keybinding conflicts.
function zvm_after_init() {
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
}
source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-completions/zsh-completions.plugin.zsh"
# NOTE: This must be the last plugin sourced to ensure it can highlight correctly.
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# source "$ZDOTDIR/plugins/bd/bd.zsh"
# source "$ZDOTDIR/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
# source "$ZDOTDIR/plugins/k/k.sh"

fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# ------------------------------------------------------------------------------
# Keybindings
# ------------------------------------------------------------------------------

source "$ZDOTDIR/keybindings.zsh"

# ------------------------------------------------------------------------------
# Initialization
# ------------------------------------------------------------------------------

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# --- FZF (fuzzy finder) ---
# FZF setup is handled in `zvm_after_init` for compatibility with zsh-vi-mode.
# The following line is redundant.
# eval "$(fzf --zsh)"

# ------------------------------------------------------------------------------
# SSH Agent
# ------------------------------------------------------------------------------
# Start ssh-agent if not already running and add key.
# This setup tries to find and reuse an existing agent per session.

SSH_ENV="$HOME/.ssh/agent-environment"

# Source agent environment if it exists
test -f "$SSH_ENV" && source "$SSH_ENV" > /dev/null
# If agent is not running, start a new one
if ! ps -p "${SSH_AGENT_PID:-0}" > /dev/null; then
    (umask 077; ssh-agent -s > "$SSH_ENV")
    source "$SSH_ENV" > /dev/null
fi
# Add key if not already loaded
if ! ssh-add -l | grep -q "id_tong"; then
    ssh-add ~/.ssh/id_tong >/dev/null 2>&1
fi
unset SSH_ENV

# ==============================================================================
# Project-specific / Temporarily Disabled
# ==============================================================================

# --- Atuin (Shell History) ---
# eval "$(atuin init zsh)"

# --- LuaRocks ---
# eval "$(luarocks path --bin)"

# --- Armory SDK ---
# export ARMSDK=$HOME/armory/armsdk
# export ARMORY_PLAY_KROM='$ARMSDK/Krom/Krom $path $resources --consolepid $pid'
# export ARMORY_PLAY_HTML5='chromium --app=$url --new-window --window-size=$width,$height --auto-open-devtools-for-tabs'

# --- Android NDK ---
# export ANDROID_NDK_HOME=/home/tong/sdk/android-ndk
# export PATH=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin:${PATH}
# export ANDROID_SYSROOT=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot
# export ANDROID_TOOLCHAIN=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64
# export ANDROID_API=21
# export ANDROID_HOME=${HOME}/sdk/android-sdk

# --- OPAM (OCaml) ---
# [[ ! -r /home/tong/.opam/opam-init/init.zsh ]] || source /home/tong/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
