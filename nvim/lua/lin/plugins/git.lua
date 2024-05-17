return {
  { "tpope/vim-fugitive", event = "BufReadPre", cmd = { "Git", "G" } },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "+",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "_",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = "‾",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = { interval = 1000, follow_files = true },
        attach_to_untracked = true,
        -- git-blame provides also the time in contrast to gitsigns
        current_line_blame = true,
        current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        diff_opts = { internal = true },
        yadm = { enable = false },
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    event = { "VeryLazy", "BufReadPre" },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      vim.env.EDITOR = "nvim"
      vim.g.lazygit_floating_window_winblend = 15
      vim.g.lazygit_floating_window_border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } -- customize lazygit popup window border characters
      vim.g.lazygit_use_neovim_remote = 0 -- fallback to 0 if neovim-remote is not installed
      require("telescope").load_extension("lazygit")
    end,
  },
}
