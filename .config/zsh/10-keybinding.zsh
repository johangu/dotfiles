bindkey -e
bindkey '^[[3~' delete-char            # Delete key
bindkey '^[[C'  forward-char           # Right key
bindkey '^[[D'  backward-char          # Left key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word            #
bindkey '^[Od' backward-word           #
bindkey '^[[1;5D' backward-word        #
bindkey '^[[1;5C' forward-word         #
bindkey '^H' backward-kill-word        # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                    # Shift+tab undo last action
#
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
