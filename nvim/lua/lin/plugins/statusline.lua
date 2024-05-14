local icons = lin.options.icons
local common = lin.utils.common
return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy", "VimEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local tcolors = require("tokyonight.colors").setup({ transform = true })
      require("lualine").setup({
        options = {
          theme = "onedark",
          component_separators = "",
          section_separators = "",
          globalstatus = true, -- enable global statusline (have a single statusline
        },
        sections = {
          lualine_a = {
            {
              function()
                local mode = {
                  -- c = "🅒",
                  -- i = "🅘",
                  -- n = "🅝",
                  -- r = "🅡",
                  -- s = "🅢",
                  -- t = "🅣",
                  -- v = "🅥",
                }
                local mode_code = vim.api.nvim_get_mode().mode
                if mode[mode_code] == nil then
                  return lin.options.mode_icons
                end
                return mode[mode_code]
              end,
              -- color = utils.get_vi_mode_color,
              separator = { right = "" },
            },
          },
          lualine_b = {
            { "filetype", icon_only = true },
            {
              "filename",
              symbols = {
                modified = "[+]",
                readonly = "[-]",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
              separator = { right = "" },
            },
          },
          lualine_c = {
            { "branch", icon = icons.git },
            {
              "diff",
              symbols = {
                added = icons.collapse .. " ",
                modified = icons.edit .. " ",
                removed = icons.expand .. " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            -- {
            --
            -- 	function()
            -- 		return require("nvim-treesitter").statusline({
            -- 			indicator_size = 70,
            -- 			type_patterns = { "class", "function", "method" },
            -- 			separator = " -> ",
            -- 		})
            -- 	end,
            -- },
          },
          lualine_x = {
            {
              common.get_lsp_clients,
              icon = icons.lsp,
              color = { fg = tcolors.purple },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = icons.error, warn = icons.warn, info = icons.info },
            },
          },
          lualine_y = {
            {
              "fileformat",
              icons_enabled = true,
              separator = { left = "" },
            },
            { "encoding", separator = { right = "" } },
          },
          lualine_z = {
            { "searchcount" },
            "location",
            "progress",
          },
        },
      })
    end,
  },
}
