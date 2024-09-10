return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = { "VeryLazy", "BufReadPre" },
    cmd = "Codeium",
    build = ":Codeium Auth",
    config = function()
      require("codeium").setup({
        -- enable_chat = true,
      })
    end,
  },
}
