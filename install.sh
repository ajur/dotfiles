#!/bin/sh
set -eu

DOTFILES=$(cd "$(dirname "$0")" && pwd)
BACKUP="$DOTFILES/_backup_$(date +%Y%m%d-%H%M%S)"

# src (relative to repo)   dest (relative to $HOME)
LINKS_COMMON="
zsh/zprofile            .zprofile
cfg/vimrc               .vimrc
cfg/tmux.conf           .tmux.conf
cfg/gitconfig           .gitconfig
cfg/gitignore           .config/git/ignore
cfg/npmrc               .npmrc
cfg/claude/CLAUDE.md    .claude/CLAUDE.md
cfg/claude/settings.json .claude/settings.json
"

LINKS_MAC="
zsh/mac.zshrc           .zshrc
cfg/ghostty             .config/ghostty
cfg/hammerspoon         .hammerspoon
cfg/hushlogin           .hushlogin
"

LINKS_SSH="
zsh/ssh.zshrc           .zshrc
"

ZSH_PLUGINS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"

# name   git url
ZSH_PLUGINS="
pure                      https://github.com/sindresorhus/pure.git
fast-syntax-highlighting  https://github.com/zdharma-continuum/fast-syntax-highlighting.git
zsh-autosuggestions       https://github.com/zsh-users/zsh-autosuggestions.git
"

usage() {
  echo "Usage: $0 [mac|ssh]"
  exit 1
}

detect_profile() {
  case "$(uname -s)" in
    Darwin) echo mac ;;
    *) echo ssh ;;
  esac
}

link() {
  src="$DOTFILES/$1"
  dst="$HOME/$2"

  if [ ! -e "$src" ]; then
    echo "missing $1"
    return
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok      ~/$2"
    return
  fi

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    mkdir -p "$(dirname "$BACKUP/$2")"
    mv "$dst" "$BACKUP/$2"
    echo "backup  ~/$2 -> $BACKUP/$2"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "linked  ~/$2"
}

link_all() {
  echo "$1" | while read -r src dst; do
    [ -z "$src" ] || link "$src" "$dst"
  done
}

clone_plugin() {
  if [ -d "$ZSH_PLUGINS_DIR/$1" ]; then
    echo "ok      $1"
    return
  fi
  git clone --quiet --depth 1 "$2" "$ZSH_PLUGINS_DIR/$1"
  echo "cloned  $1"
}

clone_plugins() {
  if ! command -v git >/dev/null; then
    echo "git not found, skipping"
    return
  fi
  mkdir -p "$ZSH_PLUGINS_DIR"
  echo "$ZSH_PLUGINS" | while read -r name url; do
    [ -z "$name" ] || clone_plugin "$name" "$url"
  done
}

PROFILE="${1:-$(detect_profile)}"

case "$PROFILE" in
  mac) LINKS_PROFILE="$LINKS_MAC" ;;
  ssh) LINKS_PROFILE="$LINKS_SSH" ;;
  *) usage ;;
esac

echo "-- profile: $PROFILE"

echo "-- link dotfiles"
link_all "$LINKS_COMMON"
link_all "$LINKS_PROFILE"

echo "-- zsh plugins"
clone_plugins

if [ "$PROFILE" = mac ]; then
  echo "-- macos settings"
  "$DOTFILES/macos.sh"
fi
