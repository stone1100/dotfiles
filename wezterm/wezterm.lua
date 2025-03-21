local Config = require("config")

-- showcases: https://github.com/wez/wezterm/discussions/628
--
require("events.right-status").setup()
require("events.tab-title").setup()
require("events.gui").setup()
-- require("events.new-tab-button").setup()
--

return Config:init()
  :append(require("config.fonts"))
  :append(require("config.launch"))
  :append(require("config.appearance"))
  :append(require("config.keymaps")).options
