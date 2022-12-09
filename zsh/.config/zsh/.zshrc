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
promp_themes+=(void)
prompt elite
source $ZDOTDIR/prompt/void.zsh

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

# Extend
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
#source $HOME/sdk/qmk_firmware/util/qmk_tab_complete.sh

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

# Keybindings
# ctrl+l used for tmux (switch pane)
# bindkey -r '^l'
# bindkey -r '^g'
# bindkey '^g' .clear-screen
# bindkey -r '^p'
# bindkey -s '^p' 'fpdf\n'
# bindkey -r '^f'
# bindkey -s '^f' 'fmind\n'
# bindkey -r '^w'
# bindkey -s '^w' 'fwork\n'
# # edit current command line with vim (vim-mode, then CTRL-v)
# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd '^v' edit-command-line
# source $ZDOTDIR/keybindings.zsh"

typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

bindkey -s '^o' 'lfcd\n'

# ## Vi mode
# bindkey -v
# export KEYTIMEOUT=1

### Add Vi text-objects for brackets and quotes
# autoload -Uz select-bracketed select-quoted
# zle -N select-quoted
# zle -N select-bracketed
# for km in viopp visual; do
#     bindkey -M $km -- '-' vi-up-line-or-history
#     for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
#         bindkey -M $km $c select-quoted
#     done
#     for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
#         bindkey -M $km $c select-bracketed
#     done
# done

### Increment a number
# autoload -Uz incarg
# zle -N incarg
# bindkey -M vicmd '^a' incarg

# cursor_mode() {
#     # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
#     cursor_block='\e[2 q'
#     cursor_beam='\e[6 q'
#     function zle-keymap-select {
#         if [[ ${KEYMAP} == vicmd ]] ||
#             [[ $1 = 'block' ]]; then
#             echo -ne $cursor_block
#         elif [[ ${KEYMAP} == main ]] ||
#             [[ ${KEYMAP} == viins ]] ||
#             [[ ${KEYMAP} = '' ]] ||
#             [[ $1 = 'beam' ]]; then
#             echo -ne $cursor_beam
#         fi
#     }
#     zle-line-init() {
#         echo -ne $cursor_beam
#     }
#     zle -N zle-keymap-select
#     zle -N zle-line-init
# }
# cursor_mode

# ### Edit command line in editor
# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
#
# ### Change surrounding
# autoload -Uz surround
# zle -N delete-surround surround
# zle -N add-surround surround
# zle -N change-surround surround
# bindkey -M vicmd cs change-surround
# bindkey -M vicmd ds delete-surround
# bindkey -M vicmd ys add-surround
# bindkey -M visual S add-surround

## Filemanager style key

# cdUndoKey() {
#   popd
#   zle       reset-prompt
#   print
#   ls
#   zle       reset-prompt
# }
#
# cdParentKey() {
#   pushd ..
#   zle      reset-prompt
#   print
#   ls
#   zle       reset-prompt
# }
#
# zle -N                 cdParentKey
# zle -N                 cdUndoKey
# bindkey '^[[1;3A'      cdParentKey
# bindkey '^[[1;3D'      cdUndoKey
#
# Extra
#eval "$(zoxide init zsh)"

#export CRON_BIN=$HOME/.local/bin/cron

export ARMSDK=$HOME/dev/armory3d/armsdk
export ARMORY_PLAY_HTML5='chromium --app=$url --new-window --window-size=$width,$height --auto-open-devtools-for-tabs'
#export ARMORY_PLAY_KROM='$ARMSDK/Krom/Krom $path $resources --consolepid $pid'

export HAXE_STD_PATH=/usr/local/share/haxe/std
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:$GOPATH/bin
#export PATH=$HOME/sdk/depot_tools/:$PATH
#export PATH=$PATH:$HOME/sdk/lua-language-server/bin
#export PATH="$HOME/src/v8/v8/out/linux:$PATH"

