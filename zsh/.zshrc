source $HOME/.env



# Config
setopt autocd
setopt beep
setopt extendedGlob
setopt interactive_comments
setopt noflowcontrol
#stty stop undef         # Disable ctrl-s to freeze terminal.

## History
HISTSIZE='128000'
SAVEHIST='96000'
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups

## Prompt
autoload -Uz promptinit && promptinit
prompt_void_setup() {
        PS1="%~%# "
}
promp_themes+=(void)
prompt elite

## Complete
autoload -Uz compinit
_comp_options+=(globdots) # include hidden files
zstyle ':complete:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
compinit

# Extend
source $HOME/.config/zsh/aliases
source $HOME/.config/zsh/aliases_user.zsh
source $HOME/.config/zsh/themes/void.zsh-theme
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# source $HOME/.config/lf/icons
#source $HOME/sdk/qmk_firmware/util/qmk_tab_complete.sh

# Path
if [ -d "$HOME/.script" ]; then PATH="$HOME/.script:$PATH"; fi
# if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi
# PATH=$HOME/src/npm-global/bin:$PATH

# Keybindings

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

# Applications

export PATH="$HOME/.cargo/bin:$PATH"
#export PATH="$HOME/src/v8/v8/out/linux:$PATH"
export PATH=$PATH:$GOPATH/bin

#export NEOVIDE_MULTIGRID

#eval "$(zoxide init zsh)"
#
