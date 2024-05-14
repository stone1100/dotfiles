return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "VeryLazy", "BufReadPre" },
    cmd = { "Conform" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports-reviser", "gofumpt" },
        typescriptreact = { "eslint_d" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 1000,
        async = true,
        lsp_fallback = true,
      },
    },
  },
}
