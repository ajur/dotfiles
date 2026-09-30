-- ~/.hammerspoon/init.lua

hs.window.animationDuration = 0

-- Start Hammerspoon at login (hotkeys only work while it runs)
hs.autoLaunch(true)

-- Enables the `hs` CLI, e.g. `hs -c "hs.reload()"`
require("hs.ipc")

require("ghostty-hotkey-window")
