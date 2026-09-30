# linked as ~/.zshrc on macOS

# repo zsh dir, resolved through the ~/.zshrc symlink
ZDOT=${${(%):-%x}:A:h}
source $ZDOT/common.zsh

## print path of the frontmost Finder window
function pfd {
  osascript -e 'tell application "Finder" to POSIX path of (target of front window as alias)'
}
## cd to the frontmost Finder window
alias cdf='cd "$(pfd)"'

## pico8 cli
if [[ -x /Applications/PICO-8.app/Contents/MacOS/pico8 ]]; then
  alias pico8=/Applications/PICO-8.app/Contents/MacOS/pico8
fi

source $ZDOT/final.zsh
