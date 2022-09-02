local api = vim.api

-- packer
local packerGrp = api.nvim_create_augroup("PackerCfgCompile", { clear = false })

local packer_compile = function()
	vim.cmd("source %")
	vim.cmd("runtime lua/plugins.lua")
	vim.cmd("PackerCompile")
	vim.notify("Packer compile completed!!!!", vim.log.levels.INFO, { title = "Packer" })
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


-- https://gist.github.com/albert-yu/18b0ad925df109b42bd3ee698f0aea6e
-- api.nvim_exec([[autocmd Filetype typescript setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab]], false)
api.nvim_create_autocmd({ "BufRead", "BufNewFile" },
	{ pattern = { "*.ts", "*.tsx", "*.js", "*.html" },
		command = "setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab" })

api.nvim_create_autocmd({ "VimEnter" }, { command = "source ~/.config/nvim/lua/highlight.lua" })
-- api.nvim_create_autocmd({ "BufRead" }, { command = "lua require('lualine').setup()" })
api.nvim_create_autocmd({ "VimEnter" }, { command = "source ~/.config/nvim/lua/config/bufferline.lua" })
