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

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit zcalc vcs_info

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

## Keybindings section
bindkey -e
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section 
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls --color' # Add colours to regular ls
alias ll='ls -l --color' # Long ls, with colours
alias la='ls -la --color' #Long ls, with colours, including "hidden" files

# "Secure" some potentially dangerous commands
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'

# list disk usage statistics for the current folder
alias duls="du -h -d1 | sort -hr"

# enable substitution for prompt
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "%F{#7aa2f7}%K{#3b4261}  %b%f %u%c%m% %k"
zstyle ':vcs_info:git:*' actionformats "  %b|%a%u%c%m% "
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr         "%F{#9ece6a}%f "
zstyle ':vcs_info:git:*' unstagedstr       "%F{#f7768e}%f "
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]="%F{#e0af68}%f "
  fi
}
precmd() { vcs_info }

# Maia prompt
PROMPT='%B%F{#1d202f}%K{#7aa2f7} %(4~|%-1~/.../%1~|%~) %k%f%b${vcs_info_msg_0_} %B%(?.%{$reset_color%}.%{$fg[red]%})>%{$reset_color%}%b '
# Right prompt with exit status of previous command if not successful
RPROMPT="%{$fg[red]%} %(?..[%?])" 

## Plugins section: Enable fish style features
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

# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey '^[[A' history-substring-search-up      
bindkey '^[[B' history-substring-search-down

# pkgfile
if [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
  export PKGFILE_PROMPT_INSTALL_MISSING=1
fi

## Function
# Easy extract
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.Z)     tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.jar)       unzip $1       ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.xz)        unxz $1        ;;
      *.zip)       7za x $1       ;;
      *.7z)        7za x $1       ;;
      *.Z)         uncompress $1  ;;
      *)           echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!";
  fi
}

# Makes directory then moves into it
function mkd() { mkdir -p -v "$@" && cd "$@"; }

# Creates an archive from given directory
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# Swap 2 filenames around, if they exist
function swap() {
  [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
  [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
  [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

  local TMPFILE=tmp.$$;

  mv "$1" $TMPFILE;
  mv "$2" "$1";
  mv $TMPFILE "$2";
}
