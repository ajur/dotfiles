-- iTerm2-style hotkey window using a regular Ghostty window (with native tabs).

local M = {}

local BUNDLE = "com.mitchellh.ghostty"

-- Screen you're currently working on: the screen of the focused window, else the one with the mouse
local function targetScreen()
  local fw = hs.window.focusedWindow()
  return (fw and fw:screen()) or hs.mouse.getCurrentScreen() or hs.screen.mainScreen()
end

function M.toggle()
  local app = hs.application.get(BUNDLE)

  if not app then
    hs.application.launchOrFocusByBundleID(BUNDLE)
    return
  end

  if app:isFrontmost() then
    app:hide()
    return
  end

  local screen = targetScreen()
  app:unhide()

  local win = app:mainWindow() or app:allWindows()[1]
  if not win then
    app:activate()
    app:selectMenuItem({ "File", "New Window" })
    return
  end

  if win:screen():id() ~= screen:id() then
    win:moveToScreen(screen, false, true, 0)
  end

  win:focus()
end

-- Raw key codes, layout-independent: same physical key left of 1
M.hotkeys = {
  hs.hotkey.bind({ "ctrl" }, 10, M.toggle), -- § on built-in ISO keyboard
  hs.hotkey.bind({ "ctrl" }, 50, M.toggle), -- ` on external ANSI keyboard
}

-- Optional: auto-hide when you click another app (like iTerm2's hotkey window)
-- M.watcher = hs.application.watcher.new(function(_, event, app)
--   if event == hs.application.watcher.deactivated and app and app:bundleID() == BUNDLE then
--     app:hide()
--   end
-- end):start()

return M
