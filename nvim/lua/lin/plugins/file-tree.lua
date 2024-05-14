local icons = lin.options.icons
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ft", "<cmd>Neotree reveal toggle<cr>", desc = "Toggle NeoTree(reveal)" },
      { "<leader>fc", "<cmd>Neotree reveal<cr>", desc = "Find Current File NeoTree" },
    },
    cmd = "Neotree",
    opts = {
      --	enable_normal_mode_for_inputs = false,
      enable_cursor_hijack = false, -- If enabled neotree will keep the cursor on the first letter of the filename when mov…
      use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
      popup_border_style = "single",
      filesystem = {
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "disabled",
        filtered_items = {
          hide_gitignored = true,
          always_show = { -- remains visible even if other settings would normally hide it
            ".gitignore",
            ".tmux.conf",
            ".zshrc",
          },
        },
      },
      window = {
        position = "left",
        width = 30,
        popup = { -- settings that apply to float position only
          relative = "editor",
          -- size = {
          --   width = "70%",
          -- },
          -- TODO: neo tree not support nui popup all opts(set vim.opt.winblend)
          -- win_options = {
          -- 	winblend = 20,
          -- },
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = icons.collapse, -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = icons.edit, -- or "", but this is redundant info if you use git_status_colors on the name
          },
        },
      },
    },
  },
}
