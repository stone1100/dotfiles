require("nvim-tree").setup({
	view = {
		hide_root_folder = false,
	},
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
})
