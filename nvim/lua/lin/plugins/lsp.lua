local icons = lin.options.icons
return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    opts = {
      ui = {
        border = "single",
      },
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      local function h(name)
        return vim.api.nvim_get_hl(0, { name = name })
      end

      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
      -- vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

      local function text_format(symbol)
        local res = {}
        -- local round_start = { " ", "SymbolUsageRounding" }
        -- local round_end = { " ", "SymbolUsageRounding" }
        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          -- table.insert(res, round_start)
          table.insert(res, { " 󰌹 ", "SymbolUsageRef" })
          table.insert(res, { ("%s %s "):format(num, usage), "SymbolUsageContent" })
          -- table.insert(res, round_end)
        end
        -- if symbol.definition then
        --   if #res > 0 then
        --     table.insert(res, { " ", "NonText" })
        --   end
        --   table.insert(res, round_start)
        --   table.insert(res, { " 󰳽 ", "SymbolUsageDef" })
        --   table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
        --   table.insert(res, round_end)
        -- end

        if symbol.implementation then
          if #res > 0 then
            table.insert(res, { " ", "NonText" })
          end
          -- table.insert(res, round_start)
          table.insert(res, { " " .. icons.down .. " ", "SymbolUsageImpl" })
          table.insert(res, { symbol.implementation .. " impls ", "SymbolUsageContent" })
          -- table.insert(res, round_end)
        end

        return res
      end

      require("symbol-usage").setup({
        vt_position = "end_of_line",
        text_format = text_format,
        request_pending_text = "",
        definition = { enabled = false },
        implementation = { enabled = true },
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    opts = function()
      return {
        ui = {
          border = "single",
          imp_sign = icons.down,
          expand = icons.expand,
          collapse = icons.collapse,
        },
        lightbulb = {
          sign = false,
        },
        outline = {
          enable = false,
          layout = "normal",
        },
        symbol_in_winbar = {
          enable = false,
        },
        implement = {
          enable = false,
        },
        floaterm = {
          height = 0.9,
          width = 0.9,
        },
        code_action = {
          show_server_name = true,
          extend_gitsigns = false,
        },
        diagnostic = {
          show_code_action = true,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy", "BufReadPre" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("lspconfig.ui.windows").default_options.border = "single"

      --local utils = require("utils")
      local nvim_lsp = require("lspconfig")
      local mason_lsp = require("mason-lspconfig")
      local lsp_util = require("lin.utils.lsp")

      mason_lsp.setup({
        ensure_installed = {
          "bashls",
          --		"sumneko_lua",
          "tsserver",
          -- "ts_ls",
          "jdtls",
          -- "stylua",
          "gopls",
          -- "golangci_lint_ls",
          "tailwindcss",
          "cssls",
          "eslint",
          "stylelint_lsp",
          "lemminx",
        },
        automatic_installation = true,
      })
      --local utils = require("utils")
      for _, name in ipairs(mason_lsp.get_installed_servers()) do
        -- if name == "gopls" then
        -- 	-- go via go.nvim
        -- 	goto continue
        -- end
        -- do cust lsp config
        local ok, _ = pcall(require, string.format("lin.lang.%s", name))
        if not ok then
          -- print(name)
          -- setup default config, if not exist
          nvim_lsp[name].setup({
            on_attach = lsp_util.on_attach,
            capabilities = lsp_util.capabilities,
          })
        end
        -- ::continue::
      end
    end,
  },
}
