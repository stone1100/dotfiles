return {
  {
    "folke/which-key.nvim",
    event = { "VeryLazy" },
    config = function()
      local wk = require("which-key")
      local silent_opt = { silent = true }
      local mode_n = { mode = "n" }
      -- local mode_v = { mode = "v" }

      wk.setup({
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { gc = "Comments" },
        key_labels = {
          -- override the label used to display some keys. It doesn't effect WK in any other way.
          -- For example:
          -- ["<space>"] = "SPC",
          -- ["<cr>"] = "RET",
          -- ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        window = {
          border = "single", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 2, -- spacing between columns
          align = "left", -- align columns left, center or right
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        hidden = {
          "<silent>",
          "<cmd>",
          "<Cmd>",
          "<cr>",
          "<CR>",
          "call",
          "lua",
          "require",
          "^:",
          "^ ",
        }, -- hide mapping boilerplate
        show_help = false, -- show help message on the command line when the popup is visible
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
      })

      -- wk.register({
      --   ["<c-q>"] = { '<cmd>"+y<cr>', "Copy" },
      -- }, { silent = true, noremap = true })
      -- dap: https://pepa.holla.cz/2022/02/02/debugging-go-in-neovim/
      wk.register({
        ["<F1>"] = { "<cmd>Telescope keymaps<cr>", "Show Keymaps" },
        ["<F8>"] = { "<cmd>lua require('dap').step_over()<cr>", "DAP Step Over" },
        ["<F7>"] = { "<cmd>lua require('dap').step_into()<cr>", "DAP Step Into" },
        ["<F9>"] = { "<cmd>lua require('dap').step_out()<cr>", "DAP Step Out" },
        ["<F6>"] = { "<cmd>lua require('dap').continue()<cr>", "DAP Continue" },
        ["<F5>"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "DAP Toggle Breakpoint" },
        K = { "<cmd>Lspsaga hover_doc<cr>", "Show Doc" },
        e = {
          name = "Diagnostic",
          a = { "<cmd>Trouble diagnostics<cr>", "Show All Diagnostics" },
          h = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Jump Previous Diagnostic" },
          l = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Jump Next Diagnostic" },
        },
        g = {
          name = "Goto",
          d = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
          i = { "<cmd>Trouble lsp_implementations<cr>", "Lsp Implements" },
        },
        ["<C-k>"] = { "<cmd>WhichKey<cr>", "Show All Mapping Keys" },
      }, { mode_n, silent_opt })

      -- mapping leader
      wk.register({
        b = {
          name = "Buffers",
          l = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer(Cycle)" },
          h = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer(Cycle)" },
          p = { "<cmd>BufferLinePick<cr>", "Pick Buffer" },
          --https://stackoverflow.com/questions/4465095/how-to-delete-a-buffer-in-vim-without-losing-the-split-window
          c = { "<cmd>:bp|bd #<cr>", "Delete Buffer" },
          o = { "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", "Delete Other Buffers" },
        },
        d = {
          name = "Debug(F5->TB F6->Continue F7->Into F8->Over F9->Out)",
          u = { "<cmd>lua require('dapui').toggle()<cr>", "DAP UI Toggle" },
          t = { "<cmd>lua require('dap').terminate()<cr>", "Terminate DAP" },
          ["bt"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "toggle Breakpoint" },
          ["bc"] = {
            "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
            "Breakpoint Condition",
          },
          ["h"] = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Widgets Hover" },
          ["l"] = { "<cmd>lua _dapui.run_last()<cr>", "Run Last" },
        },
        f = {
          name = "Files",
          s = { "<cmd>w<cr>", "Save Buffer" },
        },
        w = {
          name = "Window",
          n = { "<cmd>new<cr>", "New Window" },
          c = { "<cmd>quit<cr>", "Close Window" },
          o = { "<C-W>o", "Close Other Windows" },
          v = { "<cmd>split<cr>", "Split Window(Horizontal)" },
          s = { "<cmd>vsplit<cr>", "Split Window(Vertical)" },
          h = { "<C-W>h", "Goto Left Window" },
          l = { "<C-W>l", "Goto Right Window" },
          k = { "<C-W>k", "Goto Top Window" },
          j = { "<C-W>j", "Goto Bottom Window" },
          H = { "<C-W>H", "Move To Left Window" },
          L = { "<C-W>L", "Move To Right Window" },
          K = { "<C-W>K", "Move To Top Window" },
          J = { "<C-W>J", "Move To Bottom Window" },
          ["="] = { "<cmd>resize+5<cr>", "Increase Height" },
          ["-"] = { "<cmd>resize-5<cr>", "Decrease Height" },
          ["+"] = { "<cmd>vertical resize+5<cr>", "Increase Width" },
          ["_"] = { "<cmd>vertical resize-5<cr>", "Decrease Widht" },
          e = { "<C-W>=", "Equal Height/Width" },
        },
        h = {
          name = "Highlight",
          c = { "<cmd>noh<cr>", "Clear search highlight" },
        },
        m = {
          name = "Markdown",
          p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
          t = { "<cmd>MarkdownStop<cr>", "Markdown Stop Preview" },
        },
        o = {
          name = "Open",
          t = { "<cmd>Lspsaga term_toggle<cr>", "Open Terminal" },
        },
        v = {
          name = "View",
          ["od"] = { "<cmd>DiffviewOpen<cr>", "Open Diff View" },
          ["cd"] = { "<cmd>DiffviewClose<cr>", "Close Diff View" },
          ["dh"] = { "<cmd>DiffviewFileHistory<cr>", "View Diff File History" },
        },
        t = {
          name = "TODO",
          l = { "<cmd>Trouble todo<cr>", "List TODO" },
        },
      }, { prefix = "<leader>", mode_n, silent_opt })
    end,
  },
}
