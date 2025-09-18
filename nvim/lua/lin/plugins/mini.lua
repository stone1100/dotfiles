return {
	{
		'nvim-mini/mini.diff',
		event = "VeryLazy",
		config = function()
			require('mini.diff').setup({
				view = {
					style = 'sign', -- number or sign
					signs = { add = '+', change = '~', delete = '-' },
				},
			})
		end
	},
}
