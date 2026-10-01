## one entry per line, including hidden files
alias l='ls -1A'
## include hidden files
alias la='ls -a'
## long listing, human readable sizes, including hidden files
alias ll='ls -lhA'

## disk free, human readable
alias df='df -h'
## disk usage, human readable
alias du='du -h'
## total size of each argument
alias dus='du -hs'

## grep is ugrep when installed (same flags, faster, ug -Q for interactive search)
if (( $+commands[ugrep] )); then
  alias grep='ugrep'
else
  # highlight matches
  alias grep='grep --color=auto'
fi

## serve current dir over http on port 8000
alias srvdir='python3 -m http.server'
