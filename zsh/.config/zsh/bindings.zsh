autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
    # autoload -U up-line-or-beginning-search
    # zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search 
    bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
    # autoload -U down-line-or-beginning-search
    # zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search 
    bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line  
    bindkey -M viins "${terminfo[khome]}" beginning-of-line
    bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
    bindkey "${terminfo[kend]}" end-of-line   
    bindkey -M viins "${terminfo[kend]}"  end-of-line
    bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete  
    bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
# bindkey '\C-x\C-e' edit-command-line
bindkey '^[e' edit-command-line # Alt-e

# Exit zsh if command line is empty, otherwise clear it
exit_zsh() {
  if [[ -z "$LBUFFER" ]]; then
    exit
  else
   zle .send-break
  fi
} 
zle -N exit_zsh
bindkey '^D' exit_zsh

## Open lfcd
bindkey -s '^o' 'lfcd\n'

# handled by zsh-vi-mode ->

# zle-line-init() {
#   zle -K viins
# }
# zle -N zle-line-init
#
#
# # Optional: Make ESC show you're in normal mode (visual feedback)
# zle-keymap-select() {
#   if [[ $KEYMAP == vicmd ]]; then
#     echo -ne "\e[1 q"   # change cursor to block
#   else
#     echo -ne "\e[5 q"   # change cursor to beam
#   fi
# }
# zle -N zle-keymap-select
# # zle -K viins
#
# # Enable vi key bindings
# bindkey -v
#
# # Optional: status line indicator for mode
# function zle-line-init() {
#   zle -K viins
# }
# function zle-keymap-select() {
#   zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select
#
# # Custom keybindings in vi insert/command mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
# bindkey -M vicmd 'u' undo
# bindkey -M vicmd 'k' up-line-or-history
# bindkey -M vicmd 'j' down-line-or-history

#bindkey -v


#### double tap v in normal mode to open nvim

# open_nvim() {
#   nvim
# }
# zle -N open_nvim
# double_v_handler() {
#   local now elapsed
#   now=$EPOCHREALTIME
#
#   # If last 'v' was less than 0.4s ago, trigger Neovim
#   if [[ -n $LAST_V_TIME ]]; then
#     elapsed=$(awk "BEGIN {print $now - $LAST_V_TIME}")
#     if (( $(echo "$elapsed < 0.4" | bc -l) )); then
#       unset LAST_V_TIME
#       nvim
#       # zle open_nvim
#       return
#     fi
#   fi
#
#   # Otherwise, record time and insert literal 'v'
#   LAST_V_TIME=$now
#   zle self-insert
# }
# zle -N double_v_handler
#
# bindkey -M vicmd 'v' double_v_handler


