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

# alias cd.='cd ..'
# alias cd..='cd ..'
# alias ..='cd ..'
# alias ...='cd ../../../'
# alias ....='cd ../../../../'
# alias .....='cd ../../../../../'
# alias .2='cd ../../'
# alias .3='cd ../../../'
# alias .4='cd ../../../../'
# alias .5='cd ../../../../..'
# alias .-='cd -'

alias -- -='cd -'
alias .1='cd -1'
alias .2='cd -2'
alias .3='cd -3'
alias .4='cd -4'
alias .5='cd -5'
alias .6='cd -6'
alias .7='cd -7'
alias .8='cd -8'
alias .9='cd -9'

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias h='history 1'
alias hs='history | grep'
alias hsi='history | grep -i'

alias -g G='| grep' # Pipe commands output to grep (fe: history G nmap)

alias uppercase="tr '[:lower:]' '[:upper:]'"

alias ls="ls -hN --color=auto --group-directories-first"
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias l='ls -CF'

alias lsd='lsd --group-directories-first --color=auto'
#alias ls='lsd'

alias cpdir='cp -r'

alias diff='diff --color'

alias dirsize='du'
alias diskspace='du -S | sort -n -r | more'

alias clipcopy='cat "${1:-/dev/stdin}" | xsel --clipboard --input;'
alias clippaste='xsel --clipboard --output;'

alias md='mkdir -p'

alias df='df -h'
alias du='du -h'
alias cal='cal -m'
alias ffmpeg="ffmpeg -hide_banner"
alias ka='killall'
alias killa='killall'
alias now='date +"%T"'
#alias paths='echo -e ${PATH//:/\\n}'

# alias 'sc-show'='systemctl show'
# alias 'sc-status'='systemctl status'
# alias 'sc-start'='systemctl start'
# alias 'sc-stop'='systemctl stop'
# alias 'sc-restart'='systemctl restart'
# alias 'sc-enable'='systemctl enable'
# alias 'sc-disable'='systemctl disable'

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tka='tmux kill-server'
alias tks='tmux kill-session -t'

alias amend='git commit -a --amend'
alias clone='git clone'
alias checkout='git checkout'
alias pull='git pull'
alias push='git push'

alias wget='wget -c' # Resume wget by default

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

alias logout='xfce4-session-logout --logout'

alias zshconfig='$EDITOR $ZDOTDIR'
alias zshsource='source $ZDOTDIR/.zshrc'

