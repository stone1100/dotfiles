-- https://github.com/karb94/neoscroll.nvim
return {
  {
    "nvim-tree/nvim-web-devicons",
    event = { "VeryLazy" },
    lazy = true,
    opts = {
      override = {
        ["go.sum"] = {
          icon = "",
          color = "#519aba",
          cterm_color = "74",
          name = "GoSum",
        },
        ["go.mod"] = {
          icon = "",
          color = "#519aba",
          cterm_color = "74",
          name = "GoMod",
        },
        ["dockerfile-gh"] = {
          icon = "󰡨",
          color = "#458ee6",
          cterm_color = "68",
          name = "DockerfileGH",
        },
        css = {
          icon = "",
          color = "#934cda",
          name = "Css",
        },
      },
    },
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
    -- config = function()
    -- 	local Popup = require("nui.popup")
    -- 	local popup = Popup({
    -- 		enter = true,
    -- 		focusable = true,
    -- 		border = {
    -- 			style = "rounded",
    -- 			highlight = "FloatBorder",
    -- 		},
    -- 		position = "50%",
    -- 		size = {
    -- 			width = "80%",
    -- 			height = "60%",
    -- 		},
    -- 		buf_options = {
    -- 			modifiable = true,
    -- 			readonly = false,
    -- 		},
    -- 		win_options = {
    -- 			winblend = 10,
    -- 			winhighlight = "Normal:NeoTreeFloatNormal,FloatBorder:NeoTreeFloatBorder",
    -- 		},
    -- 	})
    --
    -- 	popup:mount()
    -- end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = false,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      -- add any options here
      views = {
        cmdline_popup = {
          border = {
            style = "single",
          },
          position = {
            row = "40%",
          },
          size = {
            width = "60%",
          },
          win_options = {
            winblend = 15,
          },
        },
        confirm = {
          border = {
            style = "single",
          },
        },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      require("telescope").load_extension("noice")
    end,
  },
  {
    "stevearc/dressing.nvim", -- vim ui(input/select ...)
    event = "VeryLazy",
    lazy = true,
    opts = {
      input = {
        border = "single",
      },
      select = {
        backend = "telescope",
        telescope = lin.utils.telescope.dropdown(),
      },
    },
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
}
