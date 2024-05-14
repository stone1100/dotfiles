return {
  {
    "akinsho/bufferline.nvim",
    event = { "VeryLazy", "VimEnter" },
    opts = function()
      local icons = lin.options.icons
      local colors = require("tokyonight.colors").setup({ transform = true })
      return {
        options = {
          mode = "buffers",
          numbers = "none", -- both
          modified_icon = lin.options.icons.modified,
          indicator = {
            icon = "",
            style = "icon",
          },
          buffer_close_icon = icons.close,
          left_trunc_marker = icons.left,
          right_trunc_marker = icons.right,
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 20,
          show_buffer_close_icons = false,
          show_buffer_icons = true,
          show_tab_indicators = true,
          always_show_bufferline = false,
          separator_style = "thick", -- "slant" | "slope" | "thick" | "thin"
          color_icons = true,
          offsets = {
            {
              filetype = "neo-tree",
              text = icons.folder_tree .. " File Explorer",
              text_align = "left",
              padding = 1,
            },
          },
          diagnostics = false, --"nvim_lsp",
          diagnostics_indicator = function(_, _, diag, _)
            -- local s = " "
            -- for e, n in pairs(diagnostics_dict) do
            --   local sym = e == "error" and icons.error or (e == "warning" and icons.warn or icons.hint)
            --   s = s .. sym .. n .. " "
            -- end
            -- return s
            local ret = (diag.error and icons.error .. diag.error .. " " or "")
              .. (diag.warning and icons.warn .. diag.warning or "")
            return vim.trim(ret)
          end,
        },
        highlights = {
          fill = {
            bg = colors.bg,
          },
          background = {
            bg = colors.bg,
          },
          warning_diagnostic = {
            fg = colors.purple,
          },
          tab = {
            bg = colors.bg,
          },
          buffer_selected = {
            fg = colors.purple,
          },
          separator = {
            fg = colors.comment,
            bg = colors.bg,
          },
          close_button = {
            bg = colors.bg,
          },
        },
      }
    end,
  },
}
