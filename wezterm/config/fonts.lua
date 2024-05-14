local wezterm = require("wezterm")

return {
  -- font = wezterm.font("GoMono Nerd Font Propo", { weight = "Bold" }),
  -- font = wezterm.font("Hack", { weight = "Bold" }),
  font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
  font_size = 14,
  line_height = 1,
  -- ref: https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
  -- ligatures: == != * -> => =~ !~ 0
  harfbuzz_features = {
    "kern",
    "liga",
    "clig",
    "thnd",
    "ss07",
    "zero",
    -- "frac",
    "txtr",
  },
}
