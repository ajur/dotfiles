# linked as ~/.zshrc on remote/ssh machines

# repo zsh dir, resolved through the ~/.zshrc symlink
ZDOT=${${(%):-%x}:A:h}
source $ZDOT/common.zsh

source $ZDOT/final.zsh
