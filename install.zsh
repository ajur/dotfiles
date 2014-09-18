#!/usr/bin/env zsh

echo "-- install/update prezto"

if [[ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
    git clone --recursive https://github.com/ajur/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
elif; then
    cd "${ZDOTDIR:-$HOME}/.zprezto"
    git fetch --all
    git reset --hard origin/master
fi

echo "-- link dotfiles"

setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    if [[ -e "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]]; then
        rm -rf "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    fi
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

for rcfile in $HOME/.dotfiles/^(README.md|install.zsh|.*); do
    if [[ -e "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]]; then
        rm -rf "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    fi
    ln -s "$rcfile" "$HOME/.${rcfile:t}"
done
