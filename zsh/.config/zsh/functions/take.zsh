# Creates a directory and changes into it.
function mkcd takedir() { # mkcd is equivalent to takedir
    mkdir -p -- "$@" && cd -- "${@:$#}"
}

# Clones a git repository and changes into the new directory.
function takegit() {
    # Clone the repository and, if successful, change into the new directory.
    git clone -- "$1" && cd -- "$(basename "${1%%.git}")"
}

# Downloads and extracts a tarball into a new directory.
function takeurl() {
    local dirname
    # Create a directory name from the tarball filename.
    # e.g. 'http://example.com/foo.tar.gz' becomes 'foo'.
    dirname=$(basename "$1" | sed -E 's/(\.tar\.(gz|bz2|xz)|\.tgz)$//')
    # Create a directory and change into it.
    mkdir -p -- "$dirname" && cd -- "$dirname" || return 1
    # Download and extract. tar auto-detects compression.
    # The output is piped directly to tar, avoiding a temp file.
    if ! (set -o pipefail; curl -L -- "$1" | tar xf -); then
        echo "Error: Download or extraction failed." >&2
        # Clean up by going back and removing the created directory.
        cd .. && rm -rf -- "$dirname"
        return 1
    fi
}

# "Smart" take function that either creates a directory, clones a git repo,
# or downloads and extracts an archive, then cds into it.
function take() {
    if [[ -z "$1" ]]; then
        echo "Usage: take <directory|git-repo-url|tarball-url>" >&2
        return 1
    fi
    # Match tarball URLs (tar.gz, tar.bz2, tar.xz, tgz)
    if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
        takeurl "$1"
    # Match various git clone URLs
    elif [[ $1 =~ ^([A-Za-z0-9]+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
        takegit "$1"
    # Default to creating a directory
    else
        takedir "$@"
    fi
}

