local api = vim.api
-- packer
local packerGrp = api.nvim_create_augroup("PackerCfgCompile", { clear = false })

local packer_compile = function()
	vim.cmd("source %")
	vim.cmd("runtime lua/plugins.lua")
	vim.cmd("PackerCompile")
	vim.notify("Packer compile completed!!!!", vim.log.levels.INFO, { title = "Packer" })
end
-- init when vim enter
vim_init = function()
	vim.cmd("set fillchars+=vert:\\|")
	vim.cmd("source ~/.config/nvim/lua/highlight.lua")
	vim.cmd("source ~/.config/nvim/lua/config/bufferline.lua")
    vim.cmd("source ~/.config/nvim/lua/config/devicons.lua")
	-- vim.cmd("source ~/.config/nvim/lua/config/bqf.lua")
	vim.cmd("lua require('dapui.config.highlights').setup()")
	vim.cmd("PackerCompile")
	vim.cmd("FormatDisable typescriptreact")
	vim.cmd("FormatDisable typescriptcommon")
	vim.cmd("FormatDisable typescript")
	-- vim.cmd([[syntax on]])

	-- fix some plugins theme not working
	local plugins = { "todo-comments", "nvim-tree" }
	for _, value in ipairs(plugins) do
		local ok, _ = pcall(require, value)
		if ok then
			require(value).setup()
		end
	end
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
	{
		pattern = { "*.ts", "*.tsx", "*.js", "*.html" },
		command = "setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab"
	})

api.nvim_create_autocmd({ "VimEnter" }, { command = "lua vim_init()" })

ShowFileSaveMessage = function()
	local filename = vim.fn.expand("%:t")
	vim.notify("Saved " .. filename, vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd(
	{ "BufWritePost" },
	{
		pattern = { "*" },
		command = "lua ShowFileSaveMessage()"
	}
)
