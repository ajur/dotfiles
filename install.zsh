#!/usr/bin/env zsh

echo "-- install slim"
git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh

echo "-- link dotfiles"

setopt EXTENDED_GLOB

for rcfile in $HOME/.dotfiles/^(README.md|install.zsh|.*); do
    if [[ -e "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]]; then
        rm -rf "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    fi
    ln -s "$rcfile" "$HOME/.${rcfile:t}"
done
