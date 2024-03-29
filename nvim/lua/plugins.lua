-- https://github.com/par4m/nvim
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

-- check packer if installed if not, install it.
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git", "clone", "https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.api.nvim_command("packadd packer.nvim")
end

-- return plugin config file
local function get_config(name)
	return string.format("require('config.%s')", name)
end

-- initialize and configure packer
local packer = require("packer")

-- init packer eli
packer.init({
	--	compile_path = compile_path,
	enable = true, -- enable profiling via :PackerCompile profile=true
	threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
	git = {
		default_url_format = 'git@github.com:%s.git' -- Lua format string used for "aaa/bbb" style plugins
	},
	-- Have packer use a popup window
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- configure plugins
packer.startup(function(use)
	-- update packer self
	use("wbthomason/packer.nvim")

	-- code completion
	use({ "rafamadriz/friendly-snippets" })
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	use({
		"L3MON4D3/LuaSnip",
		config = get_config("luasnip"),
		after = "nvim-cmp",
	})
	use({
		"uga-rosa/cmp-dictionary",
		opt = false,
		config = function()
			local dict = require("cmp_dictionary")
			dict.setup({
				exact = 2,
				max_items = 5000,
				first_case_insensitive = true,
				document = false,
				document_command = "wn %s -over",
				capacity = 5,
				debug = true,
			})
			dict.switcher({
				spelllang = {
					en = vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt"), -- "/usr/share/dict/words"
				},
			})
			dict.update() -- THIS
		end,
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/nvim-cmp",
		config = get_config("cmp"),
		-- config = function()
		-- 	require('cmp').setup({})
		-- end,
		-- event = "InsertEnter",
		-- event = "VimEnter",
		requires = {
			{ "lukas-reineke/cmp-under-comparator" },
			{ "hrsh7th/cmp-nvim-lsp", after = "LuaSnip" },
			{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
			-- { "f3fora/cmp-spell", after = "cmp-path" },
			{ "hrsh7th/cmp-buffer", after = "cmp-path" },
			{ "hrsh7th/cmp-cmdline", after = "cmp-path" },
			{ 'rcarriga/cmp-dap', after = "cmp-cmdline" },
			-- { 'uga-rosa/cmp-dictionary', config = function()
			-- 	require("cmp_dictionary").setup({
			-- 		-- The following are default values, so you don't need to write them if you don't want to change them
			-- 		exact = 2,
			-- 		first_case_insensitive = false,
			-- 		async = false,
			-- 		capacity = 5,
			-- 		debug = false,
			-- 	})
			-- end,
			-- },
		},
	})

	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})

	-- lsp install/config start
	use({ "williamboman/mason.nvim",
		config = get_config("mason"),
		requires = {
			"williamboman/mason-lspconfig.nvim",
		}
	})
	use({ "lukas-reineke/lsp-format.nvim", config = function()
		require("lsp-format").setup({})
	end })
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		config = get_config("lsp"),
		after = { "cmp-nvim-lsp", "lsp-format.nvim" },
	})
	use({ "tami5/lspsaga.nvim" })
	-- lsp context
	use({ "SmiteshP/nvim-navic", after = "nvim-lspconfig", config = get_config("navic") })
	-- set golang
	use({
		"ray-x/go.nvim",
		config = get_config("go"), ft = { "go", "gomod" },
		requires = "ray-x/guihua.lua",
	})
	use("buoto/gotests-vim")
	use({ "mfussenegger/nvim-jdtls" })
	-- set java setting
	-- use({ "mfussenegger/nvim-jdtls", opt = true, ft = { "java" }, config = get_config("java") })
	-- end java setting
	use({ "mfussenegger/nvim-dap", config = get_config("dap") })
	use({ 'theHamsta/nvim-dap-virtual-text', config = function()
		require("nvim-dap-virtual-text").setup()
	end })
	use({
		"rcarriga/cmp-dap",
		after = { "nvim-cmp", "nvim-dap", requires = 'mfussenegger/nvim-dap' },
		config = function()
			local cmp = require 'cmp'
			cmp.setup.filetype({ "dap-repl" }, {
				enabled = true,
				sources = {
					{ name = "dap" },
				},
			})
		end
	})
	use({
		"rcarriga/nvim-dap-ui",
		-- cmd = "Luadev",
		requires = { "mfussenegger/nvim-dap" },
		config = get_config("dap-ui")
	})
	use({ "leoluz/nvim-dap-go" })
	-- use({
	-- 	"fatih/vim-go",
	-- 	ft = { "go" },
	-- 	cmd = ":GoInstallBinaries",
	-- 	config = get_config("vim-go"),
	-- })
	-- lsp install/config end

	-- tools start
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = get_config("telescope"),
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = get_config("gitsigns"),
	})
	use({ "sindrets/diffview.nvim" })
	use({ "tpope/vim-fugitive", opt = true, cmd = { "Git", "G" } })
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = get_config("todo"),
	})
	use({ "windwp/nvim-autopairs", after = "nvim-cmp", config = get_config("autopairs") })
	use({ "windwp/nvim-ts-autotag", config = function()
		require("nvim-ts-autotag").setup()
	end })

	use({ "nvim-telescope/telescope-symbols.nvim" })
	use({ "nvim-telescope/telescope-project.nvim" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-packer.nvim" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "kkharji/sqlite.lua" },
	})
	use({ "folke/which-key.nvim", config = get_config("which-key") })
	use({
		"nvim-treesitter/nvim-treesitter",
		config = get_config("treesitter"),
		run = ":TSUpdate",
	})
	use({ "terrortylor/nvim-comment", config = function()
		require('nvim_comment').setup()
	end })
	-- use({ "liuchengxu/vista.vim", config = get_config("vista") })
	use({ "norcalli/nvim-colorizer.lua", config = function()
		require 'colorizer'.setup()
	end })
	use({ 'kazhala/close-buffers.nvim', config = function()
		require('close_buffers').setup()
	end })
	use({ "ThePrimeagen/refactoring.nvim", config = function()
		require('refactoring').setup({})
	end })
	use({ 'stevearc/aerial.nvim', config = function()
		require('aerial').setup({});
	end })
	use({ "ray-x/lsp_signature.nvim", config = get_config("lsp_signature") })

	-- tools end

	-- ui related config start
	-- use({ "folke/tokyonight.nvim" })
	-- use({ "ellisonleao/gruvbox.nvim" })
	use({ "navarasu/onedark.nvim", config = function()
		require('onedark').setup {
			style = 'warm'
		}
	end })
	-- use({"eddyekofo94/gruvbox-flat.nvim"})
	use("nvim-tree/nvim-web-devicons")
	use({
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeFindFileToggle" },
		config = get_config("nvim-tree"),
	})
	use({ "arkav/lualine-lsp-progress", after = "nvim-navic" })
	use({ "hoob3rt/lualine.nvim", after = "lualine-lsp-progress", config = get_config("lualine") })
	use({ "akinsho/bufferline.nvim", config = get_config("bufferline") })
	use({ "yamatsum/nvim-cursorline", config = get_config("cursorline") })
	use({ "rcarriga/nvim-notify", config = get_config("notify") })
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = get_config("dashboard"),
	})
	use({ 's1n7ax/nvim-window-picker', config = function()
		require('window-picker').setup({
			include_current_win = true,
			other_win_hl_color = '#98be65',
			current_win_hl_color = '#FF8800',
			filter_rules = {
				bo = {
					filetype = { "notify" },
				}

			}
		})
	end })
	-- ui related config end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
