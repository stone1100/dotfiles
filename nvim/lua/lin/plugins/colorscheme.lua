return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = function()
      local tcolors = require("tokyonight.colors").setup({ transform = true })
      return {
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = { italic = true },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
        on_colors = function(colors)
          colors.border = tcolors.comment
          -- colors.green = "#9ece6a"
          colors.green = "#52ad70"
        end,
        on_highlights = function(hl, c)
          lin.utils.highlights.override(hl, c)
        end,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        --style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      }
    end,
    config = function(_, opts)
      require("tokyonight").setup(opts)
    end,
  },
}
