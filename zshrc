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
alias gcane='git commit --amend --no-edit'
alias gri='git rebase -i'
alias gaa='git add .'
alias gpp='git pull --prune'
alias gm='git merge'
alias gp='git push'
alias gpf='git push --force'
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

export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

export PATH="$HOME/.dotfiles/bin:$PATH"
if [[ -d "$HOME/bin" ]]; then
  export PATH="$HOME/bin:$PATH"
fi

alias dus='du -hs'
alias srvdir='python3 -m "http.server"'
alias wg='curl -O'
alias glmd='git log --grep="Merge pull request" master..develop --pretty=format:"%s" | cut -d\  -f 8 | sort -u'

# git branch remove: force-delete local branch $1 and delete it on origin
function gbrm {
  git branch -D $1 && git push origin :$1
}
# git branch delete gone: prune remotes, then delete local branches whose upstream is gone (safe, merged only)
function gbdg {
    git pull -p > /dev/null
    git branch -vv | awk '/: gone/{print $1}' | xargs git branch -d
}
# git branch Delete gone: same as gbdg but force-deletes, including unmerged branches
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

function glhist {
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
      echo "commits authored by $AUTHOR after $MONTH within $REPO repository"
      git log --author="$AUTHOR" --after="$MONTH-01" --oneline --pretty=format:"%ad - %s" --date=short --branches
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

### fast node manager
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"
eval "$(fnm completions --shell zsh)"
alias nvm='echo "nvm is slow... using fnm instead\n\n" && fnm'

if [[ -f $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi

### direnv to handle per-dir env vars
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

### pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

### pipx
export PATH="$PATH:$HOME/.local/bin"

### or ditch pyenv, and just go with single venv
if [[ -d "$HOME/.py3" ]]; then
  export PATH="$HOME/.py3/bin:$PATH"
  export PYTHON="$HOME/.py3/bin/python"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

