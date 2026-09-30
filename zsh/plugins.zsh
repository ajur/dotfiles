# inline suggestions from history
## [keys] Right/End -- accept gray autosuggestion
if [[ -f $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $ZPLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
  # don't show suggestions while browsing history (widgets from tools.zsh)
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-up-or-fzf history-down)
fi

# command line syntax highlighting (must be loaded after all widgets)
if [[ -f $ZPLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
  source $ZPLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi
