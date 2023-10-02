alias a='archive'
alias az='archive zip'
alias bc="bc -ql"
alias c='clear'
alias ddg="ddgr"
alias e='exit'
alias ee='exit'
alias ff='lf'
alias fm='lf'
alias g='git'
alias gg='lazygit'
alias j='exa --icons'
alias jj='exa --long --git --icons'
alias ja='exa --all --git --icons'
alias jja='exa --long --all --git --icons'
alias t='task'
alias tw='timew'
alias to='taskopen'
alias tt='taskwarrior-tui --report tui'
alias tx='tmux'
alias v='$EDITOR' 
alias vv='$EDITOR .'
alias vvv='$EDITOR .'
alias x='extract'
alias '?'='ddg'

alias cal='cal -m'
alias calc='bc -q $@'
alias chat='profanity'
alias cheat='cht.sh'
alias chmox='chmod +x'
alias clipboard='kitty +kitten clipboard'
alias contact='khard'
alias contacts='khard'
alias dirsize='du'
alias email='neomutt'
alias ffmpeg="ffmpeg -hide_banner"
alias files='lfcd'
alias gist='gh gist'
alias getip='curl http://getip.disktree.net; echo'
alias icat="kitty +kitten icat"
alias img='swayimg'
alias keymap='img $HOME/doc/keymap.png'
alias lf='$HOME/.config/lf/lfrun'
alias lynx='lynx -vikeys -accept_all_cookies'
alias lock='waylock'
alias mail='neomutt'
alias notify='notify-send'
alias open='xdg-open'
alias pdf='zathura'
#alias screenshot='grim -g "$(slurp)"'
#alias screenshot='scrot -u $SCREENSHOTS/screenshot-%Y_%m_%d_%H_%M.png'
alias ultraviolet='cd $ULTRAVIOLET && nvim -c "VimwikiIndex"'
alias unzipall="fd -e zip -X unzip {} \;"
alias video='mpv'
alias weather='curl -L wttr.in/Vienna'
alias websearch='ddgr'
alias webcam-snapshot='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
alias wtri='hl $HOME/dev/lib/wtri/wtri.hl'
alias wtric='$HOME/dev/lib/wtri/wtri'
alias ytdl='yt-dlp'
alias ytdl-mp3='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio -f bestaudio --add-metadata --embed-thumbnail --audio-format mp3 "$@"'

alias waybar-reload='killall -SIGUSR2 waybar'

alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias gpuutilization='nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits'
alias meminfo='free -m -l -t'
#alias psmem='ps auxf | sort -nr -k 4'
#alias psmem10='ps auxf | sort -nr -k 4 | head -10'

alias ports='netstat -tulanp' # List open tcp/udp ports
alias checkroute='mtr $1 -tez -Q1 --ipinfo 1'

alias flipper='$HOME/sdk/qFlipper-x86_64-1.2.2.AppImage'
alias reaper='$HOME/sdk/reaper/reaper'
alias vcvrack='(cd $HOME/sdk/vcvrack/ && ./Rack)'

alias blender-armory='$HOME/sdk/blender-3.3.6/blender --app-template armory'
#alias blender3_3='$HOME/sdk/blender-3.3.6/blender'
#alias armory-electron-runtime='/home/tong/dev/armory3d/armory_electron_runtime/armory-electron-runtime-linux-x64/armory-electron-runtime'
alias krom='$ARMSDK/Krom/Krom'
alias khamake='$ARMSDK/nodejs/node-linux64 $ARMSDK/Kha/Tools/khamake/khamake.js'
alias kmake='$ARMSDK/Kha/Kinc/Tools/linux_x64/kmake'


alias -s hxml='haxe'
alias -s js='node'

#alias hldebug='hl ~/src/hashlink-debugger/debugger/debug.hl'
alias hldebug='$HOME/src/hashlink-debugger/hldebug'

alias paci="pacman -Slq | fzf --multi --prompt ' ' --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --prompt ' ' --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias vconf='nvim $HOME/.config/nvim'

alias zconfig='cd $ZDOTDIR && $EDITOR .zshrc'
alias zsource='source $ZDOTDIR/.zshrc && source $HOME/.zshenv'
#alias zstats='zshstats'

#alias clipcopy='cat "${1:-/dev/stdin}" | xsel --clipboard --input;'
#alias clippaste='xsel --clipboard --output;'

#alias fzchrome='fzf-chrome-history'
#alias fzscreenlayout='ls "$HOME/.local/share/screenlayout/" | fzf --prompt="  " | $@'
alias fzf-nerdfont='ic=$(cat ~/.local/share/nerdfont.map | fzf --prompt=" ") && echo "${ic:0:1}"'

