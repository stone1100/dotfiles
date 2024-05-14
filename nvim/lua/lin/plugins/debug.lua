return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      event = "VeryLazy",
      config = function()
        require("dapui").setup({})
      end,
    },
    {
      "leoluz/nvim-dap-go",
      event = "VeryLazy",
      config = function()
        local function get_arguments()
          return coroutine.create(function(dap_run_co)
            local args = {}
            vim.ui.input({ prompt = "Args: " }, function(input)
              args = vim.split(input or "", " ")
              coroutine.resume(dap_run_co, args)
            end)
          end)
        end

        require("dap-go").setup({
          -- Additional dap configurations can be added.
          -- dap_configurations accepts a list of tables where each entry
          -- represents a dap configuration. For more details do:
          -- :help dap-configuration
          dap_configurations = {
            {
              type = "go",
              name = "Debug Package(Arguments)",
              request = "launch",
              program = "${fileDirname}",
              args = get_arguments,
            },
          },
          -- delve configurations
          -- delve = {
          -- 	-- the path to the executable dlv which will be used for debugging.
          -- 	-- by default, this is the "dlv" executable on your PATH.
          -- 	path = "dlv",
          -- 	-- time to wait for delve to initialize the debug session.
          -- 	-- default to 20 seconds
          -- 	initialize_timeout_sec = 20,
          -- 	-- a string that defines the port to start delve debugger.
          -- 	-- default to string "${port}" which instructs nvim-dap
          -- 	-- to start the process in a random available port
          -- 	port = "${port}",
          -- 	-- additional args to pass to dlv
          -- 	args = {},
          -- 	-- the build flags that are passed to delve.
          -- 	-- defaults to empty string, but can be used to provide flags
          -- 	-- such as "-tags=unit" to make sure the test suite is
          -- 	-- compiled during debugging, for example.
          -- 	-- passing build flags using args is ineffective, as those are
          -- 	-- ignored by delve in dap mode.
          -- 	build_flags = "",
          -- 	-- whether the dlv process to be created detached or not. there is
          -- 	-- an issue on Windows where this needs to be set to false
          -- 	-- otherwise the dlv server creation will fail.
          -- 	detached = true
          -- },
        })
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      event = "VeryLazy",
      opts = {},
    },
    {
      "rcarriga/nvim-dap-ui",
      event = "VeryLazy",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      event = "VeryLazy",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },
}
