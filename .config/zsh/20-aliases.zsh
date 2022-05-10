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
