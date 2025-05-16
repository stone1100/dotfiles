local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
  CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
  CONFIG = "linux"
else
  print("Unsupported system")
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:t:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

local bundles = {
  vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar", 1), "\n"))

local lsp_util = require("lin.utils.lsp")
local util = require("lspconfig/util")
--https://github.com/abhigyanmadhukalya/dotfiles/blob/main/.config/nvim/ftplugin/java.lua
--https://github.com/mfussenegger/nvim-jdtls/wiki/Sample-Configurations
local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- override language server settings
vim.lsp.config("jdtls", {
  -- on_attach = utils.on_attach,
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()
    require("jdtls.setup").add_commands()
    --require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls").setup_dap({})
    require("jdtls.dap").setup_dap_main_class_configs()
    require("which-key").register({
      t = {
        name = "Test",
        d = { "<cmd>lua require('jdtls').test_class()<cr>", "Debug Test Java" },
        n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Run Test Nearest Method" },
      },
    }, { prefix = "<leader>", { mode = "n" }, { silent = true } })
    lsp_util.on_attach(client, bufnr)
  end,
  capabilities = lsp_util.capabilities,
  -- flags = { debounce_text_changes = 150 },
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-modules=jdk.incubator.vector",
    "--add-modules=jdk.incubator.foreign",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(mason_path .. "packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    mason_path .. "packages/jdtls/config_" .. CONFIG,
    "-data",
    workspace_dir,
  },
  filetypes = { "java" },
  root_dir = util.root_pattern({ ".idea", ".git", "mvnw", "gradlew" }),
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
    },
  },
  bundles = bundles,
  init_options = {
    bundles = bundles,
    -- fix can goto definition in lib
    extendedClientCapabilities = extendedClientCapabilities,
  },
})
