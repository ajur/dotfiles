_dotfiles_state=${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles

# show what the last background check found
if [[ -s $_dotfiles_state/notice ]]; then
  print -P "%F{yellow}dots:%f updates available, run %Bdots update%b"
  sed 's/^/  /' $_dotfiles_state/notice
fi

# weekly background check (updates zsh plugins, reports repo and brew updates)
if [[ ! -e $_dotfiles_state/last-check || -n $_dotfiles_state/last-check(#qN.md+7) ]]; then
  ${ZDOT:h}/bin/dots check &>/dev/null &!
fi

unset _dotfiles_state
