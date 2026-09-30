#!/bin/sh
# macOS system settings, safe to re-run
set -eu

# disable Ctrl+Space "Select the previous input source" (frees it for zsh set-mark)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 \
  "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"

# apply keyboard shortcut changes without logging out
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "done"
