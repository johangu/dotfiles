export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_LOCAL_HOME="${XDG_LOCAL_HOME:-$HOME/.local}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_LOCAL_STATE:-$HOME/.local/state}"

export LESSHISTFILE="${XDG_CONFIG_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"

path=(
    "./node_modules/.bin"
    "$XDG_LOCAL_HOME/bin/node_modules/bin"
    "$XDG_LOCAL_HOME/bin"
    "$HOME/bin"
    "/usr/local/bin"
    $path
  )
export PATH

################################################################################
# Homebrew
################################################################################
eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export RUST_WITHOUT=rust-docs
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=$(tty)

################################################################################
# asdf-vm
################################################################################
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/config"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="$XDG_CONFIG_HOME/asdf/tool-versions"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
source $(brew --prefix asdf)/libexec/asdf.sh

ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"

# Download Zinit, if it's not already installed
if [ ! -d "$ZINIT_HOME" ] ; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
# if [ -f "$HB_CNF_HANDLER" ]; then
#   source "$HB_CNF_HANDLER";
#   zinit snippet OMZP::command-not-found
# fi

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

[[ ! -f ~/.config/p10k.zsh ]] || source ~/.config/p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History settings
HISTSIZE=5000
HISTFILE="${XDG_CACHE_HOME}/zsh/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias ll='ls --color -l'
alias la='ls --color -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Shell integrations
eval "$(fzf --zsh)"

## make (n)vim default editor
if command -v nvim &> /dev/null; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
