--- @class lin.utils.lsp
local lsp = {}
lsp._keymapped = false

local capabilities = vim.lsp.protocol.make_client_capabilities()
lsp.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

function OpenGoTestFile()
  local file_path = vim.fn.expand("%:p")
  local target_file_path
  -- get target file path
  if file_path:match("_test.go$") then
    target_file_path = file_path:gsub("_test.go$", ".go")
  else
    target_file_path = file_path:gsub("%.go$", "_test.go")
  end

  -- check if targe file alread open, if open switch
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_path = vim.api.nvim_buf_get_name(buf)
    if buf_path == target_file_path then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  -- open target file under new window
  vim.cmd("vsplit " .. target_file_path)
end

---@diagnostic disable-next-line: unused-local
function lsp.on_attach(client, bufnr)
  if client.name == "gopls" and client.supports_method("textDocument/codeLens") then
    -- if support refresh code lens when lsp attached
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size < max_filesize then
      vim.lsp.codelens.refresh()
    end
  end

  if not lsp._keymapped then
    local wk = require("which-key")
    wk.add({
      { "<M-r>", "<cmd>lua vim.lsp.codelens.refresh()<cr>", desc = "Refresh Codelens" },
      { "<C-t>", "<cmd>Neotest run<cr>", desc = "Run Test" },
    })

    wk.add({
      { "<leader>c", group = "Coding" },
      { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      -- t = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "List Symbols" },
      { "<leader>cf", "<cmd>lua require('conform').format({timeout_ms=500,lsp_fallback=true})<cr>", desc = "Format" },
      -- { "<leader>ch", "<cmd>Telescope lsp_references<cr>", desc = "Show References" },
      {
        "<leader>ch",
        "<cmd>lua require('telescope.builtin').lsp_references({file_ignore_patterns = { '%_test.go' } })<cr>",
        desc = "Show References",
      },
      { "<leader>ci", "<cmd>Telescope lsp_implementations<cr>", desc = "Show Implements" },
      { "<leader>cc", "<cmd>Lspsaga incoming_calls<cr>", desc = "Show Incoming Calls" },
      { "<leader>cg", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Show Outgoing Calls" },
      { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
      { "<leader>cd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
      { "<leader>ck", "<cmd>Lspsaga implement<cr>", desc = "Preview Implement" },
      { "<leader>co", "<cmd>Lspsaga outline<cr>", desc = "File Outline" },
      { "<leader>cs", "<cmd>lua OpenGoTestFile()<cr>", desc = "Open Go Test File" },
      { "<leader>cla", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "Codelens Run Actions" },
      { "<leader>r", group = "Run/Test" },
      { "<leader>rd", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Test" },
      { "<leader>rt", "<cmd>Neotest run<cr>", desc = "Run Test Func" },
      { "<leader>ro", "<cmd>Neotest output<cr>", desc = "Show Test Output" },
      {
        "<leader>rf",
        "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr><cmd>Neotest summary<cr>",
        desc = "Run Tests",
      },
      { "<leader>rp", "<cmd>Neotest output-panel toggle<cr>", desc = "Toggle Test Output" },
      { "<leader>rs", "<cmd>Neotest summary toggle<cr>", desc = "Toggle Test Summary" },
      { "<leader>rcs", "<cmd>CoverageSummary<cr>", desc = "Open Coverage Summary" },
      { "<leader>rct", "<cmd>CoverageToggle<cr>", desc = "Toggle Coverage" },
    })

    lsp._keymapped = true
  end
end

return lsp
