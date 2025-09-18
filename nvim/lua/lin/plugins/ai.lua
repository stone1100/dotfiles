return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "VeryLazy", "BufReadPre" },
		cmd = "Codeium",
		build = ":Codeium Auth",
		config = function()
			require("codeium").setup({
				-- enable_chat = true,
				virtual_text = {
					enabled = false,
				},
			})
		end,
	},
}
