local keys = {}
local u = { mode = "n" }
local silent = { silent = true }

-- mapping gopls keys use whick-key
function keys.go()
	local ok, wk = pcall(require, "which-key")
	if not ok then
		-- whick-key not found
		return
	end

	wk.register({
		["<leader>t"] = {
			name = "+GoTests",
			u = { "<cmd>GoTestFunc<cr>", "Run test for current func" },
		},
	}, u, silent)
end

return keys
