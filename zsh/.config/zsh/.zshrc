setopt interactive_comments
setopt noflowcontrol
setopt AUTO_CD              # Go to folder path without using cd.
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

source $ZDOTDIR/completion.zsh

source $ZDOTDIR/functions/archive.zsh
source $ZDOTDIR/functions/autosource.zsh
#source $ZDOTDIR/functions/colors.zsh
source $ZDOTDIR/functions/confirm.zsh
source $ZDOTDIR/functions/fzf.zsh
source $ZDOTDIR/functions/git.zsh
source $ZDOTDIR/functions/img.zsh
source $ZDOTDIR/functions/lfcd.zsh
source $ZDOTDIR/functions/mail.zsh
source $ZDOTDIR/functions/take.zsh
source $ZDOTDIR/functions/zsh.zsh
#for f ($ZDOTDIR/functions/**.zsh) . $f

source $ZDOTDIR/aliases/core.zsh
source $ZDOTDIR/aliases/git.zsh
source $ZDOTDIR/aliases/nmap.zsh
source $ZDOTDIR/aliases/tmux.zsh
source $ZDOTDIR/aliases/user.zsh

function zvm_config() {
    #ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    #ZVM_VI_ESCAPE_BINDKEY=ESC
    #ZVM_VI_ESCAPE_BINDKEY=jj
    #ZVM_VI_INSERT_ESCAPE_BINDKEY=ESC
}
function zvm_after_init() {
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
}

#source $ZDOTDIR/plugins/bd/bd.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source $ZDOTDIR/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
#source $ZDOTDIR/plugins/k/k.sh

# autoload -U promptinit; promptinit
# source "$ZDOTDIR/prompt.zsh"
# autoload -Uz compinit promptinit
# compinit
# promptinit
# prompt walters
#source "$ZDOTDIR/prompt/void.zsh"
#source "$ZDOTDIR/prompt.zsh"
source "$HOME/src/spaceship-prompt/spaceship.zsh"

source "$ZDOTDIR/keybindings.zsh"

###############################################################################

export ARMSDK=$HOME/armory/armsdk
#export ARMORY_PLAY_KROM='$ARMSDK/Krom/Krom $path $resources --consolepid $pid'
#export ARMORY_PLAY_HTML5='chromium --app=$url --new-window --window-size=$width,$height --auto-open-devtools-for-tabs'

export GOPATH="$HOME/.go"
#export HAXE_STD_PATH=/usr/local/share/haxe/std
#export COLORTHEME="onedark"

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.luarocks/bin" ] && PATH="$HOME/.luarocks/bin:$PATH"
[ -d "$HOME/.npm-packages/bin" ] && PATH=$HOME/.npm-packages/bin:$PATH
[ -d "$HOME/.config/yarn/global/node_modules/.bin" ] && PATH=$HOME/.config/yarn/global/node_modules/.bin:$PATH
[ -d "$GOPATH/bin" ] && PATH="$GOPATH/bin:$PATH"

[[ ! -r /home/tong/.opam/opam-init/init.zsh ]] || source /home/tong/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

#eval "$(atuin init zsh)"
eval "$(luarocks path --bin)"
eval "$(zoxide init zsh)"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -s > "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
    source "$XDG_RUNTIME_DIR/ssh-agent.env"
    ssh-add ~/.ssh/id_rsa
fi
# if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
#     source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
# fi

