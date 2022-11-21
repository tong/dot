#alias dev='cd $HOME/dev'
#alias downloads='cd $HOME/downloads'

#alias mpv='i3-swallow mpv'
#alias neovide='i3-swallow neovide'
#alias sxiv='i3-swallow sxiv'

alias lf='$HOME/.config/lf/lfrun'
alias lynx='lynx -vikeys -accept_all_cookies'

alias alacritty-theme='python $HOME/.config/alacritty/alacritty-theme.py $@'
alias calc='bc -q $@'
alias chat='mcabber'
alias cheat='cht.sh'
alias contacts='khard'
alias email='neomutt'
alias gist='gh gist'
alias getip='curl http://getip.disktree.net; echo'
alias img='i3-swallow sxiv'
#alias img='vimiv'
alias keymap='i3-swallow sxiv $HOME/doc/keymap.png'
alias notify='notify-send'
alias pdf='zathura'
alias screenshot='scrot -u $SCREENSHOTS/screenshot-%Y_%m_%d_%H_%M.png'
alias screen-off='xset dpms force off'
alias ultraviolet='nvim -c "VimwikiIndex"'
alias weather='curl -L wttr.in'
alias wtri='hl $HOME/dev/lib/wtri/wtri.hl'
alias ytdl='yt-dlp'
alias ytdl-mp3='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3 "$@"'

alias a='archive'
alias bc="bc -ql"
#alias ddg="duckduckgo"
alias ddg="ddgr"
alias ext='extract'
alias fm='lf'
alias g='git'
alias t='task'
alias tm='timew'
alias tt='taskwarrior-tui --report tui'
alias tx='tmux'
alias v='$EDITOR' 
alias vv='$EDITOR .'
alias x='extract'
alias '?'='ddg'

alias fchrome='fzf-chrome-history'

alias -s hxml=haxe
alias -s js=node

alias closure-stylesheets='java -jar $HOME/sdk/closure-stylesheets.jar'
alias lessc-live='neko $DEV/tool/lessc-live/lessc-live.n $@'
alias luamake='$HOME/src/lua-language-server/3rd/luamake/luamake $@'
alias vscode='~/sdk/vscode/bin/code'

alias armory='blender --app-template armory'
alias krom='$ARMSDK/Krom/Krom'
alias khamake='node $ARMSDK/Kha/Tools/khamake/khamake.js'
alias kmake='$ARMSDK/Kha/Kinc/Tools/linux_x64/kmake'
#alias armory='blender -b --python $ARMSDK/armory/armory-cli.py $1'
#alias armory='blender -b $@ --python $ARMSDK/armory/armory-cli.py'
#alias armory='python $ARMSDK/armory/armory-cli.py $@'

