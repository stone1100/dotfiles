local coverage = require("coverage")
local Path = require("plenary.path")

local getCoverageFile = function()
	return vim.fn.expand("%:p:h") .. "/coverage.out"
end

-- https://github.com/andythigpen/nvim-coverage
coverage.setup({
	auto_reload = true,
	lang = {
		go = {
			coverage_file = getCoverageFile,
		},
	},
})

-- https://github.com/andythigpen/nvim-coverage/issues/28
-- automatically load the coverage signs when opening a file
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.go" }, -- any file extension you're interested in
	callback = function()
		local p = Path:new(getCoverageFile())
		-- load if coverage file exit
		if p:exists() then
			-- place (show) the signs immediately after loading
			coverage.load(true)
		end
	end,
})
