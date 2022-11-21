if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias diff='diff --color'

alias ffmpeg="ffmpeg -hide_banner"

alias ls="ls -hN --color=auto --group-directories-first"
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias l='ls -CF'
alias lsd='lsd --group-directories-first --color=auto'

alias clipcopy='cat "${1:-/dev/stdin}" | xsel --clipboard --input;'
alias clippaste='xsel --clipboard --output;'

alias diskspace='du -S | sort -n -r | more'

alias uppercase="tr '[:lower:]' '[:upper:]'"
alias lowercase="tr '[:upper:]' '[:lower:]'"

alias c='clear'
alias d='dirs -v'
alias e='exit'

alias cpr="cp -r"

alias -g G='| grep' # Pipe commands output to grep (fe: history G nmap)

alias h='history 1'
alias hs='history | grep'
alias hsi='history | grep -i'

for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias dirsize='du'

alias df='df -h'
alias du='du -h'
alias cal='cal -m'
alias ka='killall'
alias killa='killall'
alias md='mkdir -p'
alias now='date +"%T"'
#alias paths='echo -e ${PATH//:/\\n}'

# alias ta='tmux attach -t'
# alias tad='tmux attach -d -t'
# alias ts='tmux new-session -s'
# alias tl='tmux list-sessions'
# alias tka='tmux kill-server'
# alias tks='tmux kill-session -t'

alias amend='git commit -a --amend'
alias clone='git clone'
alias checkout='git checkout'
alias pull='git pull'
alias push='git push'

alias cpuinfo='lscpu'
alias meminfo='free -m -l -t'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

#alias psmem='ps auxf | sort -nr -k 4'
#alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias ip='ip addr show'
alias ports='netstat -tulanp' # List open tcp/udp ports
alias checkroute='mtr $1 -tez -Q1 --ipinfo 1'

alias paci="pacman -Slq | fzf --multi --prompt ' ' --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --prompt ' ' --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias zconfig='$EDITOR $ZDOTDIR'
alias zreload='zshreload'
alias zsource='source $ZDOTDIR/.zshrc'
alias zstats='zshstats'

alias logout='xfce4-session-logout --logout'

