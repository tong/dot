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

## Prompt
autoload -Uz promptinit && promptinit
#promp_themes+=(void)
prompt elite
#source $ZDOTDIR/prompt.zsh

## Complete
source $ZDOTDIR/completion.zsh

# Functions
source $ZDOTDIR/functions/archive.zsh
source $ZDOTDIR/functions/confirm.zsh
source $ZDOTDIR/functions/fzf.zsh
source $ZDOTDIR/functions/git.zsh
source $ZDOTDIR/functions/img.zsh
source $ZDOTDIR/functions/lfcd.zsh
source $ZDOTDIR/functions/mail.zsh
source $ZDOTDIR/functions/take.zsh
source $ZDOTDIR/functions/url.zsh
source $ZDOTDIR/functions/zsh.zsh
#source $ZDOTDIR/z.sh #TODO conflict with complete

# Plugins
source $ZDOTDIR/plugins/bd/bd.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.zsh

# ZVM_MODE_INIT_MODE=ZVM_MODE_INSERT
#ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
# ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
# ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE

# Alias
source $ZDOTDIR/aliases/core.zsh
source $ZDOTDIR/aliases/git.zsh
source $ZDOTDIR/aliases/nmap.zsh
source $ZDOTDIR/aliases/tmux.zsh
source $ZDOTDIR/aliases/user.zsh

# Path
if [ -d "$GOPATH/bin" ]; then PATH=$GOPATH/bin:$PATH; fi
if [ -d "$HOME/.bin" ]; then PATH="$HOME/.bin:$PATH"; fi
if [ -d "$HOME/.script" ]; then PATH="$HOME/.script:$PATH"; fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi
if [ -d "$HOME/src/npm-global/bin" ]; then PATH=$HOME/src/npm-global/bin:$PATH; fi

# Variables
#export CRON_BIN=$HOME/.local/bin/cron
#export ARMORY_PLAY_KROM='$ARMSDK/Krom/Krom $path $resources --consolepid $pid'
export ARMORY_PLAY_HTML5='chromium --app=$url --new-window --window-size=$width,$height --auto-open-devtools-for-tabs'
export ARMSDK=$HOME/dev/armory3d/armsdk
export HAXE_STD_PATH=/usr/local/share/haxe/std

# Paths
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:$GOPATH/bin
#export PATH=$HOME/sdk/depot_tools/:$PATH
#export PATH=$PATH:$HOME/sdk/lua-language-server/bin
#export PATH="$HOME/src/v8/v8/out/linux:$PATH"

# Prompt
source "$ZDOTDIR/prompt.zsh"

# Keybindings
source "$ZDOTDIR/keybindings.zsh"

# Extra
#eval "$(zoxide init zsh)"
