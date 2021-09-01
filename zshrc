### run slimzsh
source "$HOME/.slimzsh/slim.zsh"

unalias gl
unalias gs
unalias gpp

### pure prompt config
zstyle :prompt:pure:git:stash show yes


### basic conf
unsetopt beep

###################################################################################
### some stuff grabed from prezto

# Listings
alias l='ls -1A'         # Lists in one column, hidden files.
alias la='ls -a'         # Lists hidden files
alias ll='ls -lh'        # Lists human readable sizes.
alias lla='ll -A'        # Lists human readable sizes, hidden files.
alias sl='ls'            # I often screw this up.

# Resource Usage
alias df='df -kh'
alias du='du -kh'

# Displays user owned processes status.
function psu {
  ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

# git
_git_log_oneline_format='%C(green)%h%C(reset) %s%C(blue)%d%C(reset) %C(dim)%an %ar%C(reset)'

alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gaa='git add .'
alias gpp='git pull --prune'
alias gm='git merge'
alias gp='git push'
alias gws='git status --short'
alias gl='git log --graph --all --date-order --pretty=format:"${_git_log_oneline_format}"'
alias glb='git log --graph --date-order --pretty=format:"${_git_log_oneline_format}"'
alias glmd='git log --grep="Merge pull request" master..develop --pretty=format:"%s" | cut -d\  -f 8 | sort -u'

# macOS specific
if [[ "$OSTYPE" == darwin* ]]; then
    # Changes directory to the current Finder directory.
    alias cdf='cd "$(pfd)"'
    # Pushes directory to the current Finder directory.
    alias pushdf='pushd "$(pfd)"'
fi

###################################################################################
### custom stuff

alias dus='du -hs'
alias srvdir='python3 -m "http.server"'
alias wg='curl -O'

function gbrm {
  # git branch remove
  git branch -D $1 && git push origin :$1
}
function gbdg {
    git pull -p > /dev/null
    git branch -vv | awk '/: gone/{print $1}' | xargs git branch -d
}
function gbDg {
    git pull -p > /dev/null
    git branch -vv | awk '/: gone/{print $1}' | xargs git branch -D
}

function glmonth {
    SERVER=""
    MONTH=$1
    REPO=`git config --get remote.origin.url | sed "s/\(git@[^:]*:\)*\(http[s]*:\/\/[^/]*\/\)*\(.*\)\.git$/\3/"`
    AUTHOR=`git config --get user.email`
    if [[ ! $MONTH =~ ^[0-9]{4}-[0-9]{2}$ ]]
    then
        echo "Provide month in format YYYY-MM\nExample: $0 2018-04"
    elif [[ -z "$REPO" ||  -z "$AUTHOR" ]]
    then
        echo "Cannot find author and/or remote url.\nBe sure to run this command in git repository?"
    else
        echo "commits authored by $AUTHOR in $MONTH within $REPO repository"
        git log --author="$AUTHOR" --after=$MONTH"-01" --oneline --pretty=tformat:"%ad %H" --date=short --branches |
            awk '/^'$MONTH'/ {print "'$SERVER'/'$REPO'/commit/"$2""}'
    fi
}

# better search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# pico8
alias pico8=/Applications/PICO-8.app/Contents/MacOS/pico8

### added by jabba
[ -s "/Users/adam.jurczyk/.jabba/jabba.sh" ] && source "/Users/adam.jurczyk/.jabba/jabba.sh"

### nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion