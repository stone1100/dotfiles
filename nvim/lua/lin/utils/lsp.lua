--- @class lin.utils.lsp
local lsp = {}
lsp._keymapped = false

local capabilities = vim.lsp.protocol.make_client_capabilities()
lsp.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

---@diagnostic disable-next-line: unused-local
function lsp.on_attach(client, bufnr)
  if client.supports_method("textDocument/codeLens") then
    -- if support refresh code lens when lsp attached
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if ok and stats and stats.size < max_filesize then
      vim.lsp.codelens.refresh()
    end
  end

  if not lsp._keymapped then
    local wk = require("which-key")
    wk.register({
      ["<M-r>"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Refresh Codelens" },
      ["<C-t>"] = { "<cmd>Neotest run<cr>", "Run Test" },
    }, { { mode = "n" }, { silent = true } })

    wk.register({
      c = {
        name = "Coding",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        -- t = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "List Symbols" },
        f = { "<cmd>lua require('conform').format({timeout_ms=500,lsp_fallback=true})<cr>", "Format" },
        h = { "<cmd>Telescope lsp_references<cr>", "Show References" },
        i = { "<cmd>Telescope lsp_implementations<cr>", "Show Implements" },
        c = { "<cmd>Lspsaga incoming_calls<cr>", "Show Incoming Calls" },
        g = { "<cmd>Lspsaga outgoing_calls<cr>", "Show Outgoing Calls" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        d = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
        k = { "<cmd>Lspsaga implement<cr>", "Preview Implement" },
        o = { "<cmd>Lspsaga outline<cr>", "File Outline" },
        ["la"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Codelens Run Actions" },
      },
      r = {
        name = "Run/Test",
        d = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Test" },
        ["t"] = { "<cmd>Neotest run<cr>", "Run Test Func" },
        ["o"] = { "<cmd>Neotest output<cr>", "Show Test Output" },
        ["f"] = {
          "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr><cmd>Neotest summary<cr>",
          "Run Tests",
        },
        ["p"] = { "<cmd>Neotest output-panel toggle<cr>", "Toggle Test Output" },
        ["s"] = { "<cmd>Neotest summary toggle<cr>", "Toggle Test Summary" },
        ["cs"] = { "<cmd>CoverageSummary<cr>", "Open Coverage Summary" },
        ["ct"] = { "<cmd>CoverageToggle<cr>", "Toggle Coverage" },
      },
    }, { { mode = "n" }, { silent = true }, prefix = "<leader>" })

    lsp._keymapped = true
  end
end

return lsp
