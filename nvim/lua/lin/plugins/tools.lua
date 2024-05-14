return {
  {
    "sontungexpt/url-open",
    event = "BufReadPre",
    cmd = "URLOpenUnderCursor",
    keys = {
      {
        "<leader>gb",
        "<cmd>URLOpenUnderCursor<cr>",
        desc = "URL Open",
      },
    },
    opts = {
      -- https://github.com/sontungexpt/url-open
      open_only_when_cursor_on_url = true,
    },
  },
}
