return {
  {
    "akinsho/bufferline.nvim",
    event = { "VeryLazy", "VimEnter" },
    keys = {
      { "<A-1>", "<cmd>lua require('bufferline').go_to(1, true)<cr>", desc = "Open buffer 1" },
      { "<A-2>", "<cmd>lua require('bufferline').go_to(2, true)<cr>", desc = "Open buffer 2" },
      { "<A-3>", "<cmd>lua require('bufferline').go_to(3, true)<cr>", desc = "Open buffer 3" },
      { "<A-4>", "<cmd>lua require('bufferline').go_to(4, true)<cr>", desc = "Open buffer 4" },
      { "<A-5>", "<cmd>lua require('bufferline').go_to(5, true)<cr>", desc = "Open buffer 5" },
      { "<A-6>", "<cmd>lua require('bufferline').go_to(6, true)<cr>", desc = "Open buffer 6" },
      { "<A-7>", "<cmd>lua require('bufferline').go_to(7, true)<cr>", desc = "Open buffer 7" },
      { "<A-8>", "<cmd>lua require('bufferline').go_to(8, true)<cr>", desc = "Open buffer 8" },
      { "<A-9>", "<cmd>lua require('bufferline').go_to(9, true)<cr>", desc = "Open buffer 9" },
    },
    opts = function()
      local icons = lin.options.icons
      local colors = lin.utils.common.get_colors()
      local cust_colors = {
        bg = "#f0f0f0",
      }
      if lin.utils.common.is_dark() then
        cust_colors.bg = "#2c323c"
      end

      return {
        options = {
          mode = "buffers",
          -- numbers = "ordinal", -- both
          numbers = function(opts)
            return string.format("%s", opts.raise(opts.ordinal))
          end,
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
          separator_style = "thin", -- "slant" | "slope" | "thick" | "thin"
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
          trunc_marker = {
            bg = cust_colors.bg,
          },
          fill = {
            bg = cust_colors.bg,
          },
          group_separator = {
            bg = cust_colors.bg,
          },
          group_label = {
            bg = cust_colors.bg,
          },
          duplicate = {
            bg = cust_colors.bg,
          },
          background = {
            bg = cust_colors.bg,
          },
          warning_diagnostic = {
            fg = colors.purple,
          },
          tab = {
            bg = cust_colors.bg,
          },
          buffer_selected = {
            fg = colors.purple,
          },
          separator = {
            fg = colors.comment,
            bg = cust_colors.bg,
          },
          close_button = {
            bg = cust_colors.bg,
          },
          pick = {
            bg = cust_colors.bg,
            fg = colors.purple,
          },
          numbers = {
            bg = cust_colors.bg,
          },
          numbers_selected = {
            -- bg = cust_colors.bg,
            fg = colors.purple,
          },
          modified = {
            fg = colors.orange,
            bg = cust_colors.bg,
          },
          modified_visible = {
            fg = colors.orange,
          },
          modified_selected = {
            fg = colors.orange,
          },
        },
      }
    end,
  },
}
