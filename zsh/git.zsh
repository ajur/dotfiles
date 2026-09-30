_git_log_oneline_format='%C(green)%h%C(reset) %s%C(blue)%d%C(reset) %C(dim)%an %ar%C(reset)'

## list branches
alias gb='git branch'
## switch branch / restore files
alias gco='git checkout'
## create and switch to a new branch
alias gcb='git checkout -b'
## commit with message from the command line
alias gcm='git commit --message'
## add staged changes to the last commit, keep its message
alias gca='git commit --amend --no-edit'
## interactive rebase
alias gri='git rebase -i'
## stage everything in the current dir
alias ga='git add .'
## pull and remove refs to deleted remote branches
alias gpp='git pull --prune'
## push
alias gp='git push'
## force push, but refuse if the remote has commits you haven't seen
alias gpf='git push --force-with-lease'
## short status
alias gws='git status --short'
## graph of all branches
alias gl='git log --graph --all --date-order --pretty=format:"${_git_log_oneline_format}"'
## graph of the current branch
alias glb='git log --graph --date-order --pretty=format:"${_git_log_oneline_format}"'

## force-delete local branch $1 and delete it on origin
function gbrm {
  git branch -D $1 && git push origin :$1
}

## prune remotes, then delete local branches whose upstream is gone (merged only)
function gbdg {
  git pull -p > /dev/null
  git branch -vv | awk '/: gone/{print $1}' | xargs git branch -d
}

## same as gbdg, but force-deletes unmerged branches too
function gbDg {
  git pull -p > /dev/null
  git branch -vv | awk '/: gone/{print $1}' | xargs git branch -D
}

## print links to my commits from given month (YYYY-MM); set SERVER to the repo host url
function glmonth {
  SERVER=""
  MONTH=$1
  REPO=`git config --get remote.origin.url | sed "s/\(git@[^:]*:\)*\(http[s]*:\/\/[^/]*\/\)*\(.*\)\.git$/\3/"`
  AUTHOR=`git config --get user.email`
  if [[ ! $MONTH =~ ^[0-9]{4}-[0-9]{2}$ ]]; then
    echo "Provide month in format YYYY-MM\nExample: $0 2018-04"
  elif [[ -z "$REPO" || -z "$AUTHOR" ]]; then
    echo "Cannot find author and/or remote url.\nBe sure to run this command in git repository?"
  else
    echo "commits authored by $AUTHOR in $MONTH within $REPO repository"
    git log --author="$AUTHOR" --after=$MONTH"-01" --oneline --pretty=tformat:"%ad %H" --date=short --branches |
      awk '/^'$MONTH'/ {print "'$SERVER'/'$REPO'/commit/"$2""}'
  fi
}

## list my commits (date - subject) since given month (YYYY-MM)
function glhist {
  SERVER=""
  MONTH=$1
  REPO=`git config --get remote.origin.url | sed "s/\(git@[^:]*:\)*\(http[s]*:\/\/[^/]*\/\)*\(.*\)\.git$/\3/"`
  AUTHOR=`git config --get user.email`
  if [[ ! $MONTH =~ ^[0-9]{4}-[0-9]{2}$ ]]; then
    echo "Provide month in format YYYY-MM\nExample: $0 2018-04"
  elif [[ -z "$REPO" || -z "$AUTHOR" ]]; then
    echo "Cannot find author and/or remote url.\nBe sure to run this command in git repository?"
  else
    echo "commits authored by $AUTHOR after $MONTH within $REPO repository"
    git log --author="$AUTHOR" --after="$MONTH-01" --oneline --pretty=format:"%ad - %s" --date=short --branches
  fi
}
