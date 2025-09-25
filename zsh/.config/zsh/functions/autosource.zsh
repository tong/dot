# Auto source on enter directory
if [ -z "$AUTOSOURCE_FILE" ]; then
    autoload -U add-zsh-hook
    load-local-conf() {
        # Check file exists, regular, readable
        if [[ -f "$AUTOSOURCE_FILE" && -r $AUTOSOURCE_FILE ]]; then
            source $AUTOSOURCE_FILE 
        fi
    }
    add-zsh-hook chpwd load-local-conf
fi
