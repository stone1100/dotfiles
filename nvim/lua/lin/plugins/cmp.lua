local icons = lin.options.icons
local common = lin.utils.common
return {
  {
    "uga-rosa/cmp-dictionary",
    event = { "VeryLazy", "BufReadPre" },
    opts = function()
      local dict = {
        ["*"] = { "/usr/share/dict/words" },
        ft = {
          foo = { vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt") },
        },
      }
      return {
        exact_length = 2,
        max_number_items = 10,
        first_case_insensitive = true,
        debug = false,
        paths = dict["*"],
        document = {
          enable = false,
          command = { "w3m", "https://dict.cn/search?q=${label}" },
        },
      }
    end,
  },
  -- fixed cmdline not work
  {
    "hrsh7th/cmp-cmdline",
    event = "VeryLazy",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
      "uga-rosa/cmp-dictionary",
      "saadparwaiz1/cmp_luasnip", --NOTE: luasnip completion source
      "L3MON4D3/LuaSnip",
      "Exafunction/codeium.nvim",
    },
    opts = function()
      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        -- view = {
        --   -- entries = "custom" -- can be "custom", "wildmenu" or "native"
        --   -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#custom-menu-direction
        --   entries = { name = "custom", selection_order = "top_down", follow_cursor = true },
        -- },
        window = {
          completion = {
            border = "single",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = "single",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
          },
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
          autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
        },
        formatting = {
          format = function(entry, vim_item)
            local doc = entry.completion_item.documentation

            if vim_item.kind == "Color" and doc then
              local ok, utils = pcall(require, "tailwind-tools.utils")
              if ok then
                local content = type(doc) == "string" and doc or doc.value
                local base, _, _, _r, _g, _b = 10, content:find("rgba?%((%d+), (%d+), (%d+)")
                if not _r then
                  base, _, _, _r, _g, _b = 16, content:find("#(%x%x)(%x%x)(%x%x)")
                end
                if _r then
                  local r, g, b = tonumber(_r, base), tonumber(_g, base), tonumber(_b, base)
                  vim_item.kind_hl_group = utils.set_hl_from(r, g, b, "foreground")
                end
              end
            end

            -- load lspkind icons
            vim_item.kind = string.format("%s %s", icons[common.camel_to_snake_case(vim_item.kind)], vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[" .. icons.lsp .. " LSP ]",
              buffer = "[" .. icons.buffet .. " BuF ]",
              nvim_lua = "[" .. icons.lua .. " Nvim]",
              path = "[" .. icons.path .. " PATH]",
              luasnip = "[" .. icons.snip .. " Snip]",
              dictionary = "[" .. icons.dictionary .. " Dict]",
              codeium = "[ AI ]",
            })[entry.source.name]
            return vim_item
          end,
        },
        performance = {
          debounce = 90,
          throttle = 30,
          fetching_timeout = 200,
        },
        -- You can set mappings if you want
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.close(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-h>"] = function(fallback)
            if require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
            else
              fallback()
            end
          end,
          ["<C-l>"] = function(fallback)
            if require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
            else
              fallback()
            end
          end,
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 100 },
          { name = "luasnip", priority = 95 },
          { name = "codeium", priority = 110 },
          { name = "path", priority = 80 },
          { name = "buffer", priority = 90 },
          {
            name = "dictionary",
            keyword_length = 3,
            priority = 1,
          },
          { name = "nvim_lua" },
        }),
        -- experimental = {
        --   ghost_text = {
        --     hl_group = "CmpGhostText",
        --   },
        -- },
        sorting = defaults.sorting,
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      local cmdline_mapping = cmp.mapping.preset.cmdline({
        ["<C-j>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        },
        ["<C-k>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmdline_mapping,
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmdline_mapping,
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "benfowler/telescope-luasnip.nvim",
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").config.setup(opts)
      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
    end,
  },
}
