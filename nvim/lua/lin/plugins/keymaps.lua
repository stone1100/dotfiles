return {
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.nvim",
    },
    event = { "VeryLazy" },
    config = function()
      local wk = require("which-key")

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
        delay = 300,
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        replace = {
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
        win = {
          border = "single", -- none, single, double, shadow
          -- position = "bottom", -- bottom, top
          -- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 2, -- spacing between columns
          align = "left", -- align columns left, center or right
        },
        -- ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        -- hidden = {
        --   "<silent>",
        --   "<cmd>",
        --   "<Cmd>",
        --   "<cr>",
        --   "<CR>",
        --   "call",
        --   "lua",
        --   "require",
        --   "^:",
        --   "^ ",
        -- }, -- hide mapping boilerplate
        show_help = false, -- show help message on the command line when the popup is visible
        show_keys = false, -- show the currently pressed key and its label as a message in the command line
        -- triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        -- triggers = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        --   i = { "j", "k" },
        --   v = { "j", "k" },
        -- },
      })

      -- wk.register({
      --   ["<c-q>"] = { '<cmd>"+y<cr>', "Copy" },
      -- }, { silent = true, noremap = true })
      -- dap: https://pepa.holla.cz/2022/02/02/debugging-go-in-neovim/
      wk.add({
        { "<F1>", "<cmd>Telescope keymaps<cr>", desc = "Show Keymaps" },
        { "<F8>", "<cmd>lua require('dap').step_over()<cr>", desc = "DAP Step Over" },
        { "<F7>", "<cmd>lua require('dap').step_into()<cr>", desc = "DAP Step Into" },
        { "<F9>", "<cmd>lua require('dap').step_out()<cr>", desc = "DAP Step Out" },
        { "<F6>", "<cmd>lua require('dap').continue()<cr>", desc = "DAP Continue" },
        { "<F5>", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "DAP Toggle Breakpoint" },
        { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Show Doc" },
        { "e", group = "Diagnostic" },
        { "ea", "<cmd>Trouble diagnostics<cr>", desc = "Show All Diagnostics" },
        { "eh", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Jump Previous Diagnostic" },
        { "el", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Jump Next Diagnostic" },
        { "g", group = "Goto" },
        { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
        { "gi", "<cmd>Trouble lsp_implementations<cr>", desc = "Lsp Implements" },
        { "<C-k>", "<cmd>WhichKey<cr>", desc = "Show All Mapping Keys" },
      })

      -- mapping leader
      wk.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>bl", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer(Cycle)" },
        { "<leader>bh", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer(Cycle)" },
        --   p = { "<cmd>BufferLinePick<cr>", "Pick Buffer" },
        --   --https://stackoverflow.com/questions/4465095/how-to-delete-a-buffer-in-vim-without-losing-the-split-window
        { "<leader>bc", "<cmd>:bp|bd #<cr>", desc = "Delete Buffer" },
        { "<leader>bo", "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", desc = "Delete Other Buffers" },
        { "<leader>d", group = "Debug(F5->TB F6->Continue F7->Into F8->Over F9->Out)" },
        { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "DAP UI Toggle" },
        { "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", desc = "Terminate DAP" },
        { "<leader>dbt", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "toggle Breakpoint" },
        {
          "<leader>dbc",
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
          desc = "Breakpoint Condition",
        },
        { "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<cr>", desc = "Widgets Hover" },
        { "<leader>dl", "<cmd>lua _dapui.run_last()<cr>", desc = "Run Last" },
        { "<leader>f", group = "Files" },
        { "<leader>fs", "<cmd>w<cr>", desc = "Save Buffer" },
        { "<leader>w", group = "Window" },
        { "<leader>wn", "<cmd>new<cr>", desc = "New Window" },
        { "<leader>wc", "<cmd>quit<cr>", desc = "Close Window" },
        { "<leader>wo", "<C-W>o", desc = "Close Other Windows" },
        { "<leader>wv", "<cmd>split<cr>", desc = "Split Window(Horizontal)" },
        { "<leader>ws", "<cmd>vsplit<cr>", desc = "Split Window(Vertical)" },
        { "<leader>wh", "<C-W>h", desc = "Goto Left Window" },
        { "<leader>wl", "<C-W>l", desc = "Goto Right Window" },
        { "<leader>wk", "<C-W>k", desc = "Goto Top Window" },
        { "<leader>wj", "<C-W>j", desc = "Goto Bottom Window" },
        { "<leader>wH", "<C-W>H", desc = "Move To Left Window" },
        { "<leader>wL", "<C-W>L", desc = "Move To Right Window" },
        { "<leader>wK", "<C-W>K", desc = "Move To Top Window" },
        { "<leader>wJ", "<C-W>J", desc = "Move To Bottom Window" },
        { "<leader>w=", "<cmd>resize+5<cr>", desc = "Increase Height" },
        { "<leader>w-", "<cmd>resize-5<cr>", desc = "Decrease Height" },
        { "<leader>w+", "<cmd>vertical resize+5<cr>", desc = "Increase Width" },
        { "<leader>w_", "<cmd>vertical resize-5<cr>", desc = "Decrease Widht" },
        { "<leader>we", "<C-W>=", desc = "Equal Height/Width" },
        { "<leader>h", group = "Highlight" },
        { "<leader>hc", "<cmd>noh<cr>", desc = "Clear search highlight" },
        { "<leader>m", group = "Markdown" },
        { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
        { "<leader>mt", "<cmd>MarkdownStop<cr>", desc = "Markdown Stop Preview" },
        { "<leader>o", group = "Open" },
        { "<leader>ot", "<cmd>Lspsaga term_toggle<cr>", desc = "Open Terminal" },
        { "<leader>v", group = "View" },
        { "<leader>vod", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
        { "<leader>vcd", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
        { "<leader>vdh", "<cmd>DiffviewFileHistory<cr>", desc = "View Diff File History" },
      })
    end,
  },
}
