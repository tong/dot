alias lf='$HOME/.config/lf/lfrun'
alias lynx='lynx -cfg $HOME/.config/lynx/lynx.cfg'

alias calc='bc -q $@'
alias chat='mcabber'
alias cheat='cht.sh'
alias contacts='khard'
alias email='neomutt'
alias gist='gh gist'
alias img='vimiv'
alias pdf='zathura'
alias screenshot='scrot -u $SCREENSHOTS/screenshot-%Y_%m_%d_%H_%M.png'
alias weather='curl -L wttr.in'
alias web='lynx'

alias '?'='duckduckgo'
alias bc="bc -ql"
alias ext='extract'
alias fm='lf'
alias tt='taskwarrior-tui'
alias tw='task'
alias tx='tmux'
alias v='$EDITOR' 
alias vv='$EDITOR .'
alias x='extract'
alias ytdl='yt-dlp'

alias ultraviolet='$EDITOR -c "VimwikiIndex"'

alias alacritty-theme='python $HOME/.config/alacritty/alacritty-theme.py $@'

alias closure-stylesheets='java -jar $HOME/sdk/closure-stylesheets.jar'
#alias khamake='node $ARMSDK/Kha/make.js $@'
#alias kincmake='node $ARMSDK/Kha/Kinc/make.js $@'
alias krom='$ARMSDK/Krom/Krom $@'
alias lessc-live='neko $DEV/tool/lessc-live/lessc-live.n $@'
alias luamake='$HOME/src/lua-language-server/3rd/luamake/luamake $@'
alias ytdl-audio='ytdl --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3 "$@"'

#alias armcat='armcat $@ | jq'
#alias armory='blender -b --python $ARMSDK/armory/armory-cli.py $1'
#alias armory='blender -b $@ --python $ARMSDK/armory/armory-cli.py'
#alias armory='python $ARMSDK/armory/armory-cli.py $@'
#alias armory='blender --app-template armory $@'alias v="$EDITOR $@"
