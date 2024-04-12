require("nvim-tree").setup({
	filters = {
		dotfiles = true,
		exclude = {
			".codecov.yml",
			".gitignore",
			".golangci.yml",
			".github",
			".prettierrc.js",
			".editorconfig",
			"eslintignore",
			"eslintrc.js",
		},
		custom = {
			"cover\\.cov",
		},
	},
	git = {
		ignore = false,
	},
	renderer = {
		group_empty = true,
	},
})
