
git_num_modified_files() {
    git diff --name-only | wc -l
}

gitignore() {
    curl -fLw '\n' https://www.gitignore.io/api/"${(j:,:)@}"
}
_gitignoreio_get_command_list() {
    curl -sfL https://www.gitignore.io/api/list | tr "," "\n"
}
_gitignoreio () {
    compset -P '*,'
    compadd -S '' `_gitignoreio_get_command_list`
}
compdef _gitignoreio gitignore
