# Asks for confirmation before running a command.
#
# Usage: confirm [--root] <command> [args...]
#
#   --root: Prepend 'sudo' to the command if the user is not root.
#
# The function will display the command to be executed and prompt for [y/N]
# confirmation. Any key other than 'y' or 'Y' will cancel.
#
# It uses ${YELLOW} and ${NC} for colors if they are defined.
confirm() {
    local as_root=false
    if [[ "$1" == "--root" ]]; then
        as_root=true
        shift
    fi

    local -a prefix
    if $as_root && (( UID != 0 )); then
        prefix=(sudo)
    fi

    local answer
    # Use default empty values for colors if they are not set.
    echo -ne "zsh: sure you want to run '${YELLOW:-}${prefix[@]} $*${NC:-}' [yN]? "
    read -q answer
    echo

    if [[ "$answer:u" == "Y" ]]; then
        command "${prefix[@]}" "$@"
    else
        return 1
    fi
}

# Wrapper functions for system power commands that require confirmation and root.
hibernate() { confirm --root "$0" "$@"; }
poweroff() { confirm --root "$0" "$@"; }
reboot() { confirm --root "$0" "$@"; }

