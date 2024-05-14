-- CMD: wezterm show-keys --lua
local wezterm = require("wezterm")
-- ref: https://wezfurlong.org/wezterm/config/lua/keyassignment/index.html
local act = wezterm.action

-- SUPER, CMD, WIN ref: https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments--
-- SUPER KEY: MacOS: Command, Windows: Windows, Linux: Hyper/Super
local mod = {
  SUPER = "SUPER",
  LEADER = "LEADER",
  NONE = "NONE",
}

local keys = {
  { key = "F11", mods = mod.NONE, action = act.ToggleFullScreen },
  { key = "F12", mods = mod.NONE, action = act.ActivateCommandPalette },
  -- panes --
  -- panes: split panes
  {
    key = [[v]],
    mods = mod.LEADER,
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = [[s]],
    mods = mod.LEADER,
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },

  -- panes: navigation
  { key = "k", mods = mod.LEADER, action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = mod.LEADER, action = act.ActivatePaneDirection("Down") },
  { key = "h", mods = mod.LEADER, action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = mod.LEADER, action = act.ActivatePaneDirection("Right") },
  {
    key = "p",
    mods = mod.LEADER,
    action = act.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }),
  },
  { key = "q", mods = mod.LEADER, action = act.CloseCurrentPane({ confirm = true }) },
  -- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
  -- mode until we press some other key or until 1 second (1000ms)
  -- of time elapses
  {
    key = "t",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "activate_pane",
      timeout_milliseconds = 1000,
    }),
  },
  -- show tab switch navigator
  {
    key = [[w]],
    mods = mod.LEADER,
    action = act.ShowTabNavigator,
  },
  -- copy/paste --
  { key = "c", mods = mod.SUPER, action = act.CopyTo("Clipboard") },
  { key = "v", mods = mod.SUPER, action = act.PasteFrom("Clipboard") },
}

local key_tables = {
  -- Defines the keys that are active in our activate-pane mode.
  -- 'activate_pane' here corresponds to the name="activate_pane" in
  -- the key assignments above.
  activate_pane = {
    { key = "h", action = act.ActivatePaneDirection("Left") },
    { key = "l", action = act.ActivatePaneDirection("Right") },
    { key = "k", action = act.ActivatePaneDirection("Up") },
    { key = "j", action = act.ActivatePaneDirection("Down") },
  },
}

return {
  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = keys,
  key_tables = key_tables,
}
