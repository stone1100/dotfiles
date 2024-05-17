local colors = require("utils.colors")
local color_scheme = "Tokyo Night Storm"

return {
  -- color scheme
  color_scheme = color_scheme,
  window_background_opacity = 0.95,
  colors = {
    cursor_bg = colors.green,
    tab_bar = {
      background = colors.background,
    },
    split = colors.purple,
  },
  window_decorations = "RESIZE",
  -- window
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  enable_scroll_bar = false,
  default_cursor_style = "BlinkingUnderline",

  -- tab bar
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  show_new_tab_button_in_tab_bar = false,
  switch_to_last_active_tab_when_closing_tab = true,
}
