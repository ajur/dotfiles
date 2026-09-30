if command -v fnm >/dev/null; then
  # put node on PATH; on cd, switch to the version from .nvmrc/.node-version (searched upwards)
  eval "$(fnm env --use-on-cd --version-file-strategy recursive --shell zsh)"

  # completions, regenerated only when the fnm binary changes
  _fnm_comp=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/fnm-completions.zsh
  if [[ ! -s $_fnm_comp || $commands[fnm] -nt $_fnm_comp ]]; then
    fnm completions --shell zsh >| $_fnm_comp
  fi
  source $_fnm_comp
  unset _fnm_comp

  # muscle memory reminder
  alias nvm='echo "nvm is slow... using fnm instead\n\n" && fnm'
fi
