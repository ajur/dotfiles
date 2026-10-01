# inline suggestions from history
## [keys] Right/End -- accept gray autosuggestion
if [[ -f $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
  # don't show suggestions while browsing history (widgets from tools.zsh)
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-up-or-fzf history-down)
fi

# reminds about existing aliases when typing the full command
if [[ -f $ZPLUGINS/zsh-you-should-use/you-should-use.plugin.zsh ]]; then
  # it calls tput 5x on load for colors (~15ms); answer those without spawning tput
  function tput {
    case $1 in
      sgr0) print -n "\e[0m" ;;
      bold) print -n "\e[1m" ;;
      setaf) print -n "\e[3${2}m" ;;
    esac
  }
  source $ZPLUGINS/zsh-you-should-use/you-should-use.plugin.zsh
  unfunction tput
fi

# command line syntax highlighting (must be loaded after all widgets)
if [[ -f $ZPLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
  source $ZPLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi
