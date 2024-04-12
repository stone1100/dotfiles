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
	enable = true,                             -- enable profiling via :PackerCompile profile=true
	threshold = 0,                             -- the amount in ms that a plugins load time must be over for it to be included in the profile
	max_jobs = 20,                             -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
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
		config = get_config("cmp-dictionary"),
		after = "nvim-cmp",
		opt = false,
	})
	use({
		"hrsh7th/nvim-cmp",
		config = get_config("cmp"),
		-- event = "InsertEnter",
		-- event = "VimEnter",
		requires = {
			{ "lukas-reineke/cmp-under-comparator" },
			{ "hrsh7th/cmp-nvim-lsp",              after = "LuaSnip" },
			{ "hrsh7th/cmp-nvim-lua",              after = "cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path",                  after = "cmp-nvim-lua" },
			-- { "f3fora/cmp-spell", after = "cmp-path" },
			{ "hrsh7th/cmp-buffer",                after = "cmp-path" },
			{ "hrsh7th/cmp-cmdline",               after = "cmp-path" },
			{ 'rcarriga/cmp-dap',                  after = "cmp-cmdline" },
		},
	})

	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})

	-- lsp install/config start
	use({
		"williamboman/mason.nvim",
		config = get_config("mason"),
		requires = {
			"williamboman/mason-lspconfig.nvim",
		}
	})
	use({
		"lukas-reineke/lsp-format.nvim",
		config = function()
			require("lsp-format").setup({})
		end
	})
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		config = get_config("lsp"),
		after = { "cmp-nvim-lsp", "lsp-format.nvim" },
	})
	use({ "nvimdev/lspsaga.nvim", after = 'nvim-lspconfig', config = get_config("lspsaga") })
	-- lsp context
	-- set golang
	use({
		"ray-x/go.nvim",
		config = get_config("go"),
		ft = { "go", "gomod" },
		requires = "ray-x/guihua.lua",
	})
	-- set java setting
	use({ "mfussenegger/nvim-jdtls" })
	-- end java setting
	-- debug
	use({ "mfussenegger/nvim-dap", config = get_config("dap") })
	use({ "leoluz/nvim-dap-go", config = get_config("dap-go") })
	use({
		'theHamsta/nvim-dap-virtual-text',
		config = function()
			require("nvim-dap-virtual-text").setup()
		end
	})
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
		requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = get_config("dap-ui")
	})
	use({
		"j-hui/fidget.nvim",
		config = function()
			-- https://github.com/j-hui/fidget.nvim
			-- lsp status
			require("fidget").setup()
		end
	})
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/neotest-go",
			"nvim-treesitter/nvim-treesitter"
		},
		config = get_config("neotest"),
	})
	use({ "andythigpen/nvim-coverage", config = get_config("coverage") })
	-- lsp install/config end

	-- tools start
	use { 'nvimdev/hlsearch.nvim', event = 'BufRead', config = function()
		require('hlsearch').setup()
	end }
	use({
		'glepnir/galaxyline.nvim',
		branch = 'main',
		config = get_config("galaxy"),
		requires = { 'nvim-tree/nvim-web-devicons' },
	})
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
	use({
		"aspeddro/gitui.nvim",
		config = function()
			require("gitui").setup()
		end
	})
	use({ "sindrets/diffview.nvim" })
	use({ "tpope/vim-fugitive", opt = true, cmd = { "Git", "G" } })
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = get_config("todo"),
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end
	})

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
	use({
		"terrortylor/nvim-comment",
		config = function()
			require('nvim_comment').setup()
		end
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require 'colorizer'.setup()
		end
	})
	use({
		'kazhala/close-buffers.nvim',
		config = function()
			require('close_buffers').setup()
		end
	})
	use({ "ray-x/lsp_signature.nvim", config = get_config("lsp_signature") })
	-- tools end

	-- ui related config start
	use({
		"navarasu/onedark.nvim",
		config = function()
			require('onedark').setup {
				style = 'warm'
			}
		end
	})
	use({ "nvim-tree/nvim-web-devicons" })
	use({
		"nvim-tree/nvim-tree.lua",
		-- cmd = { "VimEnter" },
		-- config = get_config("nvim-tree"),
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
	})
	-- use({ "hoob3rt/lualine.nvim", after = "lualine-lsp-progress", config = get_config("lualine") })
	use({ "akinsho/bufferline.nvim", config = get_config("bufferline") })
	use({ "yamatsum/nvim-cursorline", config = get_config("cursorline") })
	use({ "rcarriga/nvim-notify", config = get_config("notify") })
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = get_config("dashboard"),
	})
	use({
		's1n7ax/nvim-window-picker',
		config = function()
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
		end
	})
	use({ "windwp/nvim-autopairs", after = "nvim-cmp", config = get_config("autopairs") })
	-- use { 'gen740/SmoothCursor.nvim',
	-- 	config = function()
	-- 		require('smoothcursor').setup()
	-- 	end
	-- }
	use({
		'folke/trouble.nvim',
		branch = "dev",
		event = "BufEnter",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = get_config(
			"trouble")
	})
	use({ "windwp/nvim-spectre" })
	-- ui related config end
	--
	-- use {
	-- 	"rest-nvim/rest.nvim",
	-- 	rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
	-- 	config = function()
	-- 		require("rest-nvim").setup()
	-- 	end,
	-- }
	--

	--
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
