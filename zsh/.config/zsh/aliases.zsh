if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias c='clear'
alias e='exit'
alias q='exit'

alias cd.='cd ..'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias .-='cd -'

## Directory stack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias uppercase="tr '[:lower:]' '[:upper:]'"

alias ls="ls -hN --color=auto --group-directories-first"
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias lsla='ls -la'
alias l='ls -CF'
#alias ls='lsd'

alias cpdir='cp -r'

alias dirsize='du'

alias mkdir='mkdir -pv'
alias mkd='mkdir'

alias df='df -h'
alias du='du -h'
alias cal='cal -m'
alias ffmpeg="ffmpeg -hide_banner"
alias ka='killall'
alias killa='killall'
alias now='date +"%T"'
alias paths='echo -e ${PATH//:/\\n}'
alias wget='wget -c' # Resume wget by default

alias cpuinfo='lscpu'
alias meminfo='free -m -l -t'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

#alias psmem='ps auxf | sort -nr -k 4'
#alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias ip='ip addr show'
alias ports='netstat -tulanp' # List open tcp/udp ports

alias paci="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
