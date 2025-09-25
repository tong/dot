# shellcheck shell=zsh
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
alias s='kitten ssh'
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
alias cht='cht.sh'
alias chmox='chmod +x'
# alias clipboard='cliphist list | fzf --prompt "󰅇 " --no-sort | cliphist decode | tee >(wl-copy >/dev/null 2>&1)'
alias clock='tty-clock'
alias colorpicker='hyprpicker'
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
alias lock='hyprlock'
alias lynx='lynx -vikeys -accept_all_cookies'
alias mail='neomutt'
alias notify='notify-send'
alias open='xdg-open'
alias pdf='zathura'
alias record-screen='wf-recorder -g "$(slurp)" -f output.mp4'
alias screenshot='hyprshot'
alias sunset='hyprsunset'
alias unzipall="fd -e zip -X unzip {} \;"
alias weather='curl -L wttr.in/Vienna'
alias webcam-snapshot='mpv av://v4l2:/dev/video0 --profile=low-latency --untimed'
alias wiki='cd $HOME/wiki && nvim .'
alias ytdl-mp3='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio -f bestaudio --add-metadata --embed-thumbnail --audio-format mp3 "$@"'
alias ytdl='yt-dlp'

alias nconfig='$EDITOR $XDG_CONFIG_HOME/nvim'
alias vconf='$EDITOR $HOME/.config/nvim'
alias zconfig='cd $ZDOTDIR && $EDITOR .'
alias zsource='source $ZDOTDIR/.zshrc && source $HOME/.zshenv'

#alias psmem10='ps auxf | sort -nr -k 4 | head -10'
#alias psmem='ps auxf | sort -nr -k 4'
alias meminfo='free -m -l -t'

alias checkroute='mtr $1 -tez -Q1 --ipinfo 1'
alias ports='ss -tuln' # Show open tcp/udp ports
alias connections="ss -tunap" # Show network connextions

# ---

alias -s hl='hl'
alias -s hxml='haxe'
alias -s js='node'

alias hx='haxe'
alias hldebug='hl $HOME/src/hashlink-debugger/debugger/debug.hl'
alias hlmem='hl $HASHLINK/other/haxelib/memory.hl'
alias hlprofiler='hl $HASHLINK/other/haxelib/profiler.hl'
# alias pak='hl $HOME/.local/bin/pak.hl'

alias aseprite='$HOME/sdk/aseprite/aseprite'
alias ldtk='$HOME/sdk/LDtk_1.5.3.AppImage'

# alias krom='$ARMSDK/Krom/Krom'
# alias khamake='$ARMSDK/nodejs/node-linux64 $ARMSDK/Kha/Tools/khamake/khamake.js'
# alias kmake='$ARMSDK/Kha/Kinc/Tools/linux_x64/kmake'

alias flipper='$HOME/sdk/qFlipper-x86_64-1.2.2.AppImage'
alias godot='$HOME/sdk/Godot_v4.2.2/Godot_v4.2.2-stable_linux.x86_64'
alias reaper='$HOME/sdk/reaper/reaper'
alias vcvrack='(cd $HOME/sdk/vcvrack/ && ./Rack)'

# ---

alias paci="pacman -Slq | fzf --multi --prompt ' ' --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacr="pacman -Qq | fzf --multi --prompt ' ' --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias fnerdfont='fzf-nerdfont'
alias fchrome='fzf-chrome-history'

# ---

alias waybar-reload='killall -SIGUSR2 waybar'
