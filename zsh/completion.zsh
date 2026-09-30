_zcache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
mkdir -p $_zcache

# menu selection widgets
zmodload -i zsh/complist

# full security check only if the dump is older than 24h, otherwise fast load
autoload -Uz compinit
if [[ -n $_zcache/zcompdump(#qN.mh+24) ]]; then
  compinit -d $_zcache/zcompdump
else
  compinit -C -d $_zcache/zcompdump
fi

# complete from the cursor position, not only at the end of a word
setopt complete_in_word
# move the cursor to the end of the word after completing
setopt always_to_end

# navigable completion menu (arrows / Tab / Shift-Tab)
zstyle ':completion:*' menu select
# case-insensitive, then partial words (f.b -> foo.bar), then substring
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# color completion lists like ls
zstyle ':completion:*' list-colors ''
# for cd, prefer local dirs over named dirs and cdpath
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# don't offer system usernames (~user) as completions
zstyle ':completion:*' users off
# cache results of slow completions (brew, apt, ...)
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $_zcache/compcache

unset _zcache
