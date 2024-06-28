alias a='archive'
alias az='archive zip'
alias bc="bc -ql"
alias c='clear'
alias ddg="ddgr"
alias e='exit'
alias ff='lf'
alias fm='lf'
alias g='git'
alias gg='lazygit'
alias j='exa --icons'
alias ja='exa --all --git --icons'
alias jj='exa --long --git --icons'
alias jja='exa --long --all --git --icons'
alias m="neomutt"
alias t='task'
alias to='taskopen'
alias tt='taskwarrior-tui --report tui'
alias tw='timew'
alias tx='tmux'
alias v='$EDITOR' 
alias vv='$EDITOR .'
alias vvv='$EDITOR .'
alias ww='cd $HOME/wiki && nvim .'
alias x='extract'
alias '?'='ddg'

alias biz='cd $HOME/disktree/biz-cli && hl biz.hl'
alias cal='cal -m'
alias calc='bc -q $@'
alias chat='profanity'
alias cheat='cht.sh'
alias chmox='chmod +x'
alias clip='kitty +kitten clipboard'
alias clipboard='kitty +kitten clipboard'
alias colorpicker='hyprpicker --no-fancy'
alias contact='khard'
alias contacts='khard'
alias dirsize='du'
alias email='neomutt'
alias ffmpeg="ffmpeg -hide_banner"
alias files='lfcd'
alias gist='gh gist'
alias icat="kitty +kitten icat"
alias img='swayimg'
alias keymap='img $HOME/doc/keymap.png'
alias lf='$HOME/.config/lf/lfrun'
alias lock='waylock'
alias lynx='lynx -vikeys -accept_all_cookies'
alias mail='neomutt'
alias notify='notify-send'
alias open='xdg-open'
alias pdf='zathura'
alias unzipall="fd -e zip -X unzip {} \;"
alias weather='curl -L wttr.in/Vienna'
alias webcam-snapshot='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
#alias wiki='cd $HOME/wiki && nvim . -c "WikiPages"'
alias wiki='cd $HOME/wiki && nvim . +"Telescope find_files"'
alias wtri='hl $HOME/dev/lib/wtri/wtri.hl'
alias wtric='$HOME/dev/lib/wtri/wtri'
alias ytdl-mp3='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio -f bestaudio --add-metadata --embed-thumbnail --audio-format mp3 "$@"'
alias ytdl='yt-dlp'

alias nconfig='$EDITOR $XDG_CONFIG_HOME/nvim'
alias vconf='$EDITOR $HOME/.config/nvim'

alias zconfig='cd $ZDOTDIR && $EDITOR .'
alias zsource='source $ZDOTDIR/.zshrc && source $HOME/.zshenv'
#alias zstats='zshstats'

#alias clipcopy='cat "${1:-/dev/stdin}" | xsel --clipboard --input;'
#alias clippaste='xsel --clipboard --output;'

#alias psmem10='ps auxf | sort -nr -k 4 | head -10'
#alias psmem='ps auxf | sort -nr -k 4'
alias meminfo='free -m -l -t'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias gpuutilization='nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits'

alias checkroute='mtr $1 -tez -Q1 --ipinfo 1'
alias ports='netstat -tulanp' # List open tcp/udp ports

alias paci="pacman -Slq | fzf --multi --prompt ' ' --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --prompt ' ' --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias waybar-reload='killall -SIGUSR2 waybar'

alias fnerdfont='fzf-nerdfont'
alias fchrome='fzf-chrome-history'
#alias fzscreenlayout='ls "$HOME/.local/share/screenlayout/" | fzf --prompt="  " | $@'

# ---

alias -s hxml='haxe'
alias -s js='node'

#alias blender-armory='$HOME/sdk/blender-3.3.6/blender --app-template armory'
alias blender3='$HOME/sdk/blender-3.6.11/blender'
#alias blender3_3='$HOME/sdk/blender-3.3.6/blender'
#alias armory-electron-runtime='/home/tong/dev/armory3d/armory_electron_runtime/armory-electron-runtime-linux-x64/armory-electron-runtime'
alias hldebug='$HOME/src/hashlink-debugger/hldebug'
#alias hldebug='hl ~/src/hashlink-debugger/debugger/debug.hl'
alias krom='$ARMSDK/Krom/Krom'
alias khamake='$ARMSDK/nodejs/node-linux64 $ARMSDK/Kha/Tools/khamake/khamake.js'
alias kmake='$ARMSDK/Kha/Kinc/Tools/linux_x64/kmake'

alias flipper='$HOME/sdk/qFlipper-x86_64-1.2.2.AppImage'
alias godot='$HOME/sdk/Godot_v4.2.2/Godot_v4.2.2-stable_linux.x86_64'
alias reaper='$HOME/sdk/reaper/reaper'
alias vcvrack='(cd $HOME/sdk/vcvrack/ && ./Rack)'
