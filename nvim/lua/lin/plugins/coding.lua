return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ta", "<cmd>Trouble todo<cr>", desc = "Show TODO List" },
      { "th", "<cmd>lua require('todo-comments').jump_prev()<cr>", desc = "Previous todo comment" },
      { "tl", "<cmd>lua require('todo-comments').jump_next()<cr>", desc = "Next todo comment" },
    },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "VeryLazy", "BufReadPre" }, -- lazy load
    opts = {
      --fix:
      --fixme:
      --TODO:
      --FIX:
      --HACK:
      --NOTE:
      --OPT:
      --WARN: warn
      --TEST: test
      --bug:
      --
      --FIX
      --TODO
      --todo
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      keywords = {
        fix = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        hack = { icon = " ", color = "warning" },
        perf = { icon = "󰄉 ", alt = { "optim", "performance", "optimize", "opt", "OPT" } },
        todo = { icon = "󰱒 ", color = "info" },
        warn = { icon = " ", color = "warning", alt = { "warning", "xxx" } },
        note = { icon = " ", color = "hint", alt = { "info" } },
        test = { icon = "󰰤 ", color = "test", alt = { "testing", "passed", "failed" } },
      },
      colors = {
        info = { "#82aaff" },
      },
      highlight = {
        -- keyword = "",
        before = "",
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        -- pattern = [[\b(KEYWORDS)]],
      },
      signs = true, -- show icons in the signs column
      search = {
        -- command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        -- pattern = [[\b(KEYWORDS)\b]],
        -- pattern = [[\b(KEYWORDS):?\b]],
        -- pattern = [[\b(KEYWORDS)(:?)\b]],
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    },
  },
  -- {
  --   "ahmedkhalf/project.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   event = { "VeryLazy", "BufReadPre" },
  --   opts = {
  --     patterns = { "stylua.toml", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
  --   },
  --   config = function(_, opts)
  --     --**project.nvim** comes with the following mappings:
  --     --| Normal mode | Insert mode | Action                     |
  --     --| ----------- | ----------- | -------------------------- |
  --     --| f           | \<c-f\>     | find\_project\_files       |
  --     --| b           | \<c-b\>     | browse\_project\_files     |
  --     --| d           | \<c-d\>     | delete\_project            |
  --     --| s           | \<c-s\>     | search\_in\_project\_files |
  --     --| r           | \<c-r\>     | recent\_project\_files     |
  --     --| w           | \<c-w\>     | change\_working\_directory |
  --     require("project_nvim").setup(opts)
  --     require("telescope").load_extension("projects")
  --   end,
  -- },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    "folke/trouble.nvim",
    event = { "VeryLazy" },
    -- cmd = { "TroubleToggle", "Trouble" },
    opts = {
      pinned = true,
      focus = true, -- Focus the window when opened
      indent_guides = true, -- show indent guides
      preview = { type = "split", border = "single", position = "right", relative = "win", size = 0.5 },
      wid = {
        border = "single",
      },
    },
  },
  {
    "nvimdev/hlsearch.nvim",
    event = { "VeryLazy", "BufReadPre" },
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    event = { "VeryLazy", "BufReadPre" },
    config = true,
  },
  {
    "sontungexpt/stcursorword",
    event = { "VeryLazy", "BufReadPre" },
    config = true,
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      {

        "andythigpen/nvim-coverage",
        config = function()
          local coverage = require("coverage")
          local Path = require("plenary.path")

          local getCoverageFile = function()
            return vim.fn.expand("%:p:h") .. "/coverage"
          end

          -- https://github.com/andythigpen/nvim-coverage
          coverage.setup({
            auto_reload = true,
            lang = {
              go = {
                coverage_file = function()
                  return getCoverageFile() .. ".out"
                end,
              },
            },
            summary = {
              width_percentage = 0.70,
              height_percentage = 0.50,
              borders = {
                topleft = "┌",
                topright = "┐",
                botleft = "└",
                botright = "┘",
              },
            },
          })

          -- https://github.com/andythigpen/nvim-coverage/issues/28
          -- automatically load the coverage signs when opening a file
          vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = { "*.go" }, -- any file extension you're interested in
            callback = function()
              local p = Path:new(getCoverageFile() .. ".tmp")
              -- load if coverage file exit
              if p:exists() then
                local cmd = "cat " .. p .. " |grep -v '_mock.go' > " .. getCoverageFile() .. ".out"
                os.execute(cmd)
                -- place (show) the signs immediately after loading
                coverage.load(true)
              end
            end,
          })
        end,
      },
    },
    config = function()
      local icons = lin.options.icons
      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=120s", "-race", "-coverprofile=coverage.tmp" },
          }),
        },
        --	strategies = { "dap" },
        icons = {
          running_animated = {
            "⣾",
            "⣽",
            "⣻",
            "⢿",
            "⡿",
            "⣟",
            "⣯",
            "⣷",
          },
          unknown = icons.head_question,
          collapsed = icons.collapse,
          expanded = icons.expand,
          passed = icons.todo,
          running = icons.run_last,
          failed = icons.close,
          -- https://www.compart.com/en/unicode/block/U+2500
          final_child_prnjix = "└",
        },
        summary = {
          open = "botright vsplit | vertical resize 35",
        },
        floating = {
          border = "single",
        },
        --log_level = vim.log.levels.DEBUG,
      })
    end,
  },
  {
    "danymat/neogen",
    event = { "VeryLazy", "BufReadPre" },
    keys = {
      { "<leader>nc", "<cmd>Neogen<cr>", desc = "Gen doc" },
    },
    config = true,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "typescript", "typescriptreact", "css", "scss" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {},
    config = function()
      require("tailwind-tools").setup({
        server = {
          override = false,
          -- on_attach = function(client, bufnr)
          --   -- callback executed when the language server gets attached to a buffer
          --   lsp_util.on_attach(client, bufnr)
          -- end,
          -- root_dir = function(fname)
          --   local util = require("lspconfig/util")
          --   local git_root = util.find_git_ancestor(fname)
          --   if git_root then
          --     -- fix monorepo
          --     return git_root
          --   end
          --   return util.root_pattern("package.json")
          -- end,
        },
      })
    end,
  },
}
