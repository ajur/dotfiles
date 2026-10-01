_dots_state=${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles

# banner on shell start: face + date, then a fun nudge or what the last background check found
function _dots_welcome {
  local -a art text notes
  local color line i
  local fg_green=$'\e[32m' fg_yellow=$'\e[33m' dim=$'\e[2m' bold=$'\e[1m' reset=$'\e[0m'
  local width=$(( COLUMNS - 12 ))

  [[ -s $_dots_state/notice ]] && notes=(${(f)"$(<$_dots_state/notice)"})

  local now='%D{%A, %f %B · %H:%M}'
  text=("$bold${(%)now}$reset")

  if (( $#notes )); then
    color=$fg_yellow
    art=(
      ' ()_()'
      ' (o.O)'
      "'(\")(\")'"
    )
    text+=("${fg_yellow}oh no, updates waiting: run ${bold}dots update$reset")
    for line in $notes; do
      (( $#line > width )) && line="${line[1,width-1]}…"
      text+=("$dim$line$reset")
    done
  else
    local -a fun=(
      'all good. go make something fun'
      'all good. pixel art time? Aseprite is waiting'
      'all good. that ticket won'"'"'t close itself'
      'all good. write that devlog'
      'all good. a shader a day: glslViewer'
      'all good. break something, then fix it'
      'all good. some game jam is always on'
    )
    color=$fg_green
    art=(
      ' ()_()'
      ' (^.^)'
      "'(\")(\")'"
    )
    text+=("$fg_green${fun[RANDOM % $#fun + 1]}$reset")
  fi

  for (( i = 1; i <= ${#art} || i <= ${#text}; i++ )); do
    print -r -- "$color${(r:8:)art[i]}$reset  ${text[i]}"
  done
}

[[ -t 1 ]] && _dots_welcome
unfunction _dots_welcome

# weekly background check (updates zsh plugins, reports repo and brew updates)
if [[ ! -e $_dots_state/last-check || -n $_dots_state/last-check(#qN.md+7) ]]; then
  ${ZDOT:h}/bin/dots check &>/dev/null &!
fi

unset _dots_state
