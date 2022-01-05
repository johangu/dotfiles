export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_LOCAL_HOME="${XDG_LOCAL_HOME:-$HOME/.local}"
export XDG_STATE_HOME="${XDG_LOCAL_STATE:-$HOME/.local/state}"
export GIT_HOME="$HOME/Documents/git"
export ANDROID_HOME="$HOME/.android/development"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/config"
export ASDF_DATA_DIR="$$XDG_DATA_HOME/asdf"
export SDL_VIDEODRIVER=wayland
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export SAM_CLI_TELEMETRY=0

# make tmux XDG_CONFIG_HOME "compatible"
command -v tmux &> /dev/null && alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

## make (n)vim default editor
if command -v nvim &> /dev/null; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

export PAGER=less
export MANPAGER=$PAGER
# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

export GPG_TTY=$(tty)

PATH="$HOME/.pub-cache/bin:$PATH"
PATH="$XDG_LOCAL_HOME/bin:$PATH"
PATH="$HOME/.nodenv/bin:$HOME/.pyenv/bin:$HOME/.rbenv/bin:$PATH"
PATH="$GIT_HOME/github.com/flutter/flutter/bin:$PATH"
PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"
PATH="./node_modules/.bin:$XDG_LOCAL_HOME/bin/node_modules/bin:$(npm get prefix)/bin:$PATH"
export PATH
