autoload -Uz vcs_info

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

PROMPT='%B%F{#ffffff}%K{#E95420}   %F{#1d202f}%K{#7aa2f7} %(4~|%-1~/.../%1~|%~) %k%f%b${vcs_info_msg_0_} %B%(?.%{$reset_color%}.%{$fg[red]%})>%{$reset_color%}%b '

# Right prompt with exit status of previous command if not successful
RPROMPT="%{$fg[red]%} %(?..[%?])" 
