#!/usr/bin/env zsh

echo "-- install slim"
git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh

echo "-- link dotfiles"

setopt EXTENDED_GLOB

for rcfile in $HOME/.dotfiles/^(README.md|install.zsh|ghostty|.*); do
    if [[ -e "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]]; then
        rm -rf "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    fi
    ln -s "$rcfile" "$HOME/.${rcfile:t}"
done

mkdir -p "$HOME/.config"
rm -rf "$HOME/.config/ghostty"
ln -s "$HOME/.dotfiles/ghostty" "$HOME/.config/ghostty"

echo "-- post install setup"

git config --global core.excludesFile '~/.gitignore_global'

if [[ "$OSTYPE" == darwin* ]]; then
    echo "-- macos settings"

    # Disable Ctrl+Space "Select the previous input source" (frees it for zsh set-mark)
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 \
      "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
fi
