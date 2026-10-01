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

# zoxide: z / zi jump to frecent dirs, plain cd untouched
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# claude: turn a description on the command line into a command (only placed on the line, not run)
if command -v claude >/dev/null; then
  ## [keys] Alt-E -- replace the line with a command generated from its description (claude, ~5-10s); Ctrl-_ undoes
  # system prompt; lists installed formulae with their "##" notes from the Brewfile, so answers use (and teach) those tools
  function _ai_command_prompt {
    local tools
    [[ -r ${ZDOT:h}/Brewfile ]] && tools=$(awk '
      /^## / { c = substr($0, 4); next }
      /^brew "/ { n = $0; sub(/^brew "/, "", n); sub(/".*/, "", n); print "- " n (c != "" ? ": " c : "") }
      { c = "" }
    ' ${ZDOT:h}/Brewfile)
    print -r -- "You convert a description into a single shell command for zsh on macOS \
(BSD userland: BSD sed, du, find, date, stat; no GNU-only flags). \
The user's git email is $(git config user.email). \
Reply with exactly one command line (pipes, && and zsh globs allowed). \
No explanation, no markdown, no code fences. \
Do not add steps that were not asked for, especially deleting or overwriting files. \
If the input already is a command, return it fixed or improved.

Installed Homebrew tools (package: what it is for). When one of them fits the task well, \
prefer it over the classic Unix tool, so the user learns it:
$tools"
  }

  function ai-command {
    [[ -z $BUFFER ]] && return
    local out sys=$(_ai_command_prompt)

    POSTDISPLAY=$'\n'"asking claude…"
    zle -R
    {
      out=$(print -r -- $BUFFER | claude -p --model haiku --tools "" --no-session-persistence \
        --disable-slash-commands --system-prompt $sys 2>/dev/null)
    } always {
      POSTDISPLAY=
    }

    # drop code fences and surrounding whitespace
    out=${(F)${(f)out}:#\`\`\`*}
    out=${${out##[[:space:]]##}%%[[:space:]]##}

    if [[ -n $out ]]; then
      BUFFER=$out
      CURSOR=$#BUFFER
    else
      zle -M "claude: no answer"
    fi
  }
  zle -N ai-command
  bindkey '^[e' ai-command
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
