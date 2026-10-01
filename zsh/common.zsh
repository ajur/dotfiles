# plugins cloned by install.sh
ZPLUGINS=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins
# repo scripts
path=(${ZDOT:h}/bin $path)

source $ZDOT/options.zsh
source $ZDOT/completion.zsh
source $ZDOT/prompt.zsh
source $ZDOT/aliases.zsh
source $ZDOT/git.zsh
source $ZDOT/node.zsh
source $ZDOT/tools.zsh
source $ZDOT/welcome.zsh
