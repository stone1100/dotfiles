local dap = require("dap")

dap.configurations.java = {
	{
		type = 'java',
		request = 'attach',
		name = "Debug (Attach) local process",
		-- pid = require('dap.utils').pick_process,
		processId = "${command:pickProcess}",
		hostName = "localhost",
		port = 9598,
		console = 'internalConsole',
	},
}
