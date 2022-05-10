## Options section
#setopt correct                                                  # Auto correct mistakes
setopt share_history # share history between sessions ???
setopt extended_history # add timestamps to history

setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

. ${HOME}/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit

_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*:descriptions' format "$fg[green]%B--- %d%b"
zstyle ':completion:*' group-name ''
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}"/zsh
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
HISTCONTROL=ignoredups
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

for script in ${XDG_CONFIG_HOME}/zsh/*.zsh; do
	source $script
done

## Plugins section: Enable fish style features
# Check if zplug is installed
if [ ! -d ~/.zplug ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source ~/.zplug/init.zsh

# Use syntax highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Use history substring search
zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# pkgfile
if [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
  export PKGFILE_PROMPT_INSTALL_MISSING=1
fi
