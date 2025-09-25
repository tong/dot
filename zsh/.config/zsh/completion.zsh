# shellcheck shell=zsh
fpath=(
    "$ZDOTDIR/plugins/zsh-completions/src" # 3rd-party zsh-completions plugin
    "$ZDOTDIR/complete"                    # User-specific local completions
    $fpath
)

zmodload zsh/complist

# Initialize the completion system.
# -i: ignore insecure directories (for security)
# -d: specify the dump file path for caching, improving startup time
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
autoload -U compinit; compinit -i -d "$ZSH_COMPDUMP"

# Include hidden files (dotfiles) in completions
_comp_options+=(globdots)

# ------------------------------------------------------------------------------
# Completion Options (setopt)
# ------------------------------------------------------------------------------

setopt MENU_COMPLETE        # Automatically highlight the first completion entry.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from anywhere in a word, not just the beginning.
# setopt GLOB_COMPLETE      # Expand glob patterns in completion. Can be noisy.

# ------------------------------------------------------------------------------
# Completion Styles (zstyle)
# ------------------------------------------------------------------------------

# --- General Settings ---

# Use a cache for performance
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"

# Enable the completion menu
zstyle ':completion:*' menu select

# Keep the prefix of the word being completed
zstyle ':completion:*' keep-prefix true

# --- Matching Control ---
# Defines how matches are found. This enables fuzzy matching.
# ''                  : First, try an exact prefix match.
# 'm:{a-zA-Z}={A-Za-z}': Case-insensitive matching.
# 'r:|[._-]=* r:|=*'  : Match after a separator (e.g., `.` `_` `-`).
# 'l:|=* r:|=*'      : Match from both left and right of the word.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# --- Formatting & Display ---

# Group completions by their type (e.g., 'aliases', 'functions')
zstyle ':completion:*' group-name ''

# Set the order for some groups when completing commands
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Custom formatting for different parts of the completion menu
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue} %D %d %f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Use LS_COLORS for file and directory completion colors
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# --- Command-specific Settings ---

# Sort files by name
zstyle ':completion:*' file-sort name

# For `cd`, show local directories, directory stack, and path directories in order
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# Autocomplete options for cd instead of directory stack
zstyle ':completion:*:*:cd:*' complete-options true


# For `ssh`/`scp`, complete hosts from known_hosts files
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Define a completer for `vman` to use `man`'s completions
compdef vman="man"

# ------------------------------------------------------------------------------
# Custom Completions & Keybindings
# ------------------------------------------------------------------------------

# --- Alias Expansion ---
# Custom widget to expand an alias on demand with Ctrl-X, a
zle -C alias-expansion complete-word _generic
bindkey '^Xa' alias-expansion
zstyle ':completion:alias-expansion:*' completer _expand_alias
zstyle ':completion:alias-expansion:*' menu no # Disable menu for this specific completion
zstyle ':completion:alias-expansion:*' complete true # Perform completion on the alias expansion

# --- Vi-style keybindings for menu (currently disabled) ---
# These can conflict with other settings. Enable with caution.
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
