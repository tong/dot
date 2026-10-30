# Open files or URLs with the default application, detached from the shell
# so the terminal is neither blocked nor spammed with the application's output.
open() {
    xdg-open "$@" >/dev/null 2>&1 &|
}
