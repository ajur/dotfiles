# fzf
if command -v fzf >/dev/null; then
  ## [keys] Ctrl-R -- fuzzy history search
  ## [keys] Ctrl-T -- fuzzy find file, insert its path
  ## [keys] Alt-C -- fuzzy find subdirectory, cd into it
  source <(fzf --zsh)

  ## [keys] Up -- previous command; with text typed: fuzzy history search
  # Up on empty line or while browsing history: previous entry; with own text typed: fzf history search
  # (browsing = line unchanged since the last Up/Down)
  function history-up-or-fzf {
    if [[ -z $BUFFER || $BUFFER == $_history_nav_buffer ]]; then
      zle up-line-or-history
      _history_nav_buffer=$BUFFER
    else
      zle fzf-history-widget
    fi
  }
  # Down: next entry, keeps browsing state for history-up-or-fzf
  function history-down {
    zle down-line-or-history
    _history_nav_buffer=$BUFFER
  }
  zle -N history-up-or-fzf
  zle -N history-down
  bindkey '^[[A' history-up-or-fzf
  bindkey '^[OA' history-up-or-fzf
  bindkey '^[[B' history-down
  bindkey '^[OB' history-down
fi

# direnv: load/unload .envrc on cd
if command -v direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

# sdkman: java sdk manager
if [[ -s $HOME/.sdkman/bin/sdkman-init.sh ]]; then
  export SDKMAN_DIR=$HOME/.sdkman

  # put current version of each installed candidate on PATH, set JAVA_HOME, MAVEN_HOME, ...
  for _c in $SDKMAN_DIR/candidates/*/current(N); do
    path=($_c/bin $path)
    export ${(U)${_c:h:t}}_HOME=$_c
  done
  unset _c

  # load full sdkman only on first use of `sdk`
  function sdk {
    unfunction sdk
    source $SDKMAN_DIR/bin/sdkman-init.sh
    sdk "$@"
  }
fi
