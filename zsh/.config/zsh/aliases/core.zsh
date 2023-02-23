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

alias c='clear'
alias e='exit'

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
alias cal='cal -m'
alias ka='killall'
alias killa='killall'
alias now='date +"%T"'
#alias paths='echo -e ${PATH//:/\\n}'

alias h='history 1'
alias hs='history | grep'
alias hsi='history | grep -i'

alias -g G='| grep' # Pipe commands output to grep (fe: history G nmap)

alias diff='diff --color'

alias uppercase="tr '[:lower:]' '[:upper:]'"
alias lowercase="tr '[:upper:]' '[:lower:]'"

alias chmox='chmod +x'

alias dirsize='du'
alias diskspace='du -S | sort -n -r | more'

alias cpuinfo='lscpu'
alias meminfo='free -m -l -t'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias gpuutilization='nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits'
#alias psmem='ps auxf | sort -nr -k 4'
#alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias ip='ip addr show'
alias ports='netstat -tulanp' # List open tcp/udp ports
alias checkroute='mtr $1 -tez -Q1 --ipinfo 1'

alias paci="pacman -Slq | fzf --multi --prompt ' ' --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --prompt ' ' --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias vconfig='$EDITOR $HOME/.config/nvim'

alias zconfig='cd $ZDOTDIR && $EDITOR .zshrc'
alias zreload='zshreload'
alias zsource='source $ZDOTDIR/.zshrc'
alias zstats='zshstats'

