if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias ls="ls -hN --color=auto --group-directories-first"
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias l='ls -CF'
alias lla='ls -la'

alias md="mkdir -p"
alias rd="rmdir"
alias cr="cp -r"

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias df='df -h'
alias du='du -h'
alias now='date +"%T"'
#alias paths='echo -e ${PATH//:/\\n}'

alias h='history 1'
alias hs='history | grep'
alias hsi='history | grep -i'

alias diff='diff --color'

alias timestamp="date +%s"

alias uppercase="tr '[:lower:]' '[:upper:]'"
alias lowercase="tr '[:upper:]' '[:lower:]'"

alias -g G='| grep' # Pipe commands output to grep (fe: history G nmap)
