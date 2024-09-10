return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    event = { "VeryLazy" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "davidmh/mdx.nvim",
    ft = { "markdown" },
    event = { "VeryLazy" },
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
