if [[ -d $ZPLUGINS/pure ]]; then
  fpath+=($ZPLUGINS/pure)
  autoload -Uz promptinit && promptinit
  # show ≡ when there are stashed changes
  zstyle :prompt:pure:git:stash show yes
  prompt pure
else
  # fallback until plugins are installed
  PROMPT='%~ %# '
fi
