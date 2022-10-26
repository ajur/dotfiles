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
alias glmd='git log --grep="Merge pull request" master..develop --pretty=format:"%s" | cut -d\  -f 8 | sort -u'

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

# print all commits links from given month
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
if [[ -f /Applications/PICO-8.app/Contents/MacOS/pico8 ]]; then
    alias pico8=/Applications/PICO-8.app/Contents/MacOS/pico8
fi

### haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

### nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

function run_nvm_use_for_current_dir {
    nvmrc_files=`ls (../)#.nvmrc(:a) 2>/dev/null`
    node_version=`node -v`
    
    if [[ -z $nvmrc_files ]]
    then
        default_nvm_node_version=`nvm version default`
        if [[ $default_nvm_node_version != $node_version ]]
        then
            nvm use default
        fi
        return
    fi

    nvmrc_node_version=`echo $nvmrc_files | tail -1 | xargs cat 2> /dev/null`
    
    if [[ $nvmrc_node_version != $node_version ]]
    then
        nvm use $nvmrc_node_version
    fi
}

### on dir change
function chpwd {
    run_nvm_use_for_current_dir
}
chpwd # run for new shell also

if [[ -f $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi

### pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
