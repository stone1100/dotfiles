local api = vim.api

-- packer
local packerGrp = api.nvim_create_augroup("PackerCfgCompile", { clear = false })

local packer_compile = function()
	vim.cmd("source %")
	vim.cmd("runtime lua/plugins.lua")
	vim.cmd("PackerCompile")
	vim.notify("Packer Compiled!!!!", vim.log.levels.INFO, { title = "Packer" })
end

-- watch all packer config modify, if yes need to do packer compile.
api.nvim_create_autocmd(
	{ "BufWritePost" },
	{
		pattern = { "plugins.lua", "utils.lua", "*/config/*.lua", "*/server/*.lua" },
		callback = packer_compile,
		group = packerGrp,
	}
)
