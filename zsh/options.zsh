# general

# cd into a directory by typing just its name
setopt autocd
# advanced globbing: ^pattern, pattern~exclude, glob qualifiers
setopt extendedglob
# pass unmatched globs through as-is instead of erroring (e.g. git log HEAD^)
setopt nonomatch
# no terminal bell
unsetopt beep
# free Ctrl-S / Ctrl-Q from terminal flow control
unsetopt flowcontrol
# drop duplicate entries from PATH and fpath
typeset -U path fpath

# colored ls output on macOS/BSD
export CLICOLOR=1
# let less display color escape codes
export LESS=-FRX

# history

HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=1000000
SAVEHIST=1000000
# store timestamp and duration with each entry
setopt extended_history
# write commands to history immediately, not on shell exit
setopt inc_append_history
# when a command repeats, remove its older entry
setopt hist_ignore_all_dups
# don't show duplicates when searching history
setopt hist_find_no_dups
# don't write duplicates to the history file
setopt hist_save_no_dups
# trim superfluous whitespace from entries
setopt hist_reduce_blanks
# don't record commands starting with a space
setopt hist_ignore_space
# show expanded history substitution (!!, !$) before running it
setopt hist_verify

# keys

# emacs-style line editing
bindkey -e
# Home / End / Delete for various terminal escape sequences
bindkey '^[[H' beginning-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OF' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
## [keys] Shift-Tab -- previous item in completion menu
bindkey '^[[Z' reverse-menu-complete
# word motions/deletions stop at any non-alphanumeric char (/ . - _)
WORDCHARS=''
