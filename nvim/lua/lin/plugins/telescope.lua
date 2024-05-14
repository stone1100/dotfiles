return {
  {
    "nvim-telescope/telescope.nvim",
    event = { "VeryLazy", "BufReadPre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
      { "<leader>fd", "<cmd>TodoTelescope<cr>", desc = "Find todo lists" },
      { "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find workspace symbols" },
    },
    opts = function()
      local open_with_trouble = require("trouble.sources.telescope").open
      return {
        pickers = {
          lsp_references = {
            include_declaration = false,
          },
        },
        defaults = {
          mappings = {
            i = { ["<c-l>"] = open_with_trouble },
            n = { ["<c-l>"] = open_with_trouble },
          },
        },
      }
    end,
    config = function(_, opts)
      --NOTE: cannot add by opts, telescope not load
      opts.defaults = vim.tbl_deep_extend("force", lin.utils.telescope.dropdown(), opts.defaults)
      require("telescope").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "BufReadPre",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "BufReadPre",
    config = function()
      require("telescope").load_extension("undo")
    end,
  },
  {
    "OliverChao/telescope-picker-list.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "t",
        "<cmd>TelescopePickers<cr>",
        desc = "List All Telescope Pickers(include extensions)",
      },
    },
    config = function()
      require("telescope").load_extension("picker_list")
      -- create user command
      vim.api.nvim_create_user_command("TelescopePickers", function()
        require("telescope").extensions.picker_list.picker_list(lin.utils.telescope.dropdown())
      end, { desc = "List all telescope pickers" })
    end,
  },
}
