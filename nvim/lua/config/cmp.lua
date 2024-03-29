local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local border = function(hl)
	return {
		{ "╭", hl },
		{ "─", hl },
		{ "╮", hl },
		{ "│", hl },
		{ "╯", hl },
		{ "─", hl },
		{ "╰", hl },
		{ "│", hl },
	}
end

local cmp = require("cmp")
cmp.setup({
	view = {
		-- entries = "custom" -- can be "custom", "wildmenu" or "native"
		-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#custom-menu-direction
		entries = { name = 'custom', selection_order = 'near_cursor' }
	},
	window = {
		completion = {
			border = border("CmpBorder"),
			winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
		},
		documentation = {
			border = border("CmpBorder"),
			winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
		},
	},
	sorting = {
		comparators = {
			-- require("cmp_tabnine.compare"),
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	formatting = {
		format = function(entry, vim_item)
			local lspkind_icons = {
				Text = "",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰇽",
				Variable = "󰂡",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰩵",
				Unit = "",
				Value = "󰎠",
				Enum = "",
				Keyword = "󱕵",
				Snippet = "",
				Color = "󰸌",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			}
			-- load lspkind icons
			vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

			vim_item.menu = ({
				nvim_ls = "[ LSP]",
				-- cmp_tabnine = "[TN]",
				buffer = "[󰕸 BuF]",
				orgmode = "[ORG]",
				nvim_lua = "[LUA]",
				path = "[PATH]",
				tmux = "[TMUX]",
				luasnip = "[󰅩 LSnip]",
				--spell = "[SPELL]",
				dictionary = "[󰗊 Dict]",
			})[entry.source.name]

			return vim_item
		end,
	},
	performance = {
		debounce = 90,
		throttle = 30,
		fetching_timeout = 200,
	},
	-- You can set mappings if you want
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-h>"] = function(fallback)
			if require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
			else
				fallback()
			end
		end,
		["<C-l>"] = function(fallback)
			if require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
			else
				fallback()
			end
		end,
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	-- You should specify your *installed* sources.
	sources = cmp.config.sources({
		--{ name = "dap" },
		{ name = "nvim_lsp" },
		--{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		-- {
		-- 	name = "spell",
		-- 	option = {
		-- 		keep_all_entries = false,
		-- 		enable_in_context = function()
		-- 			return true
		-- 		end,
		-- 	},
		-- },
		--{ name = "orgmode" },
		--{ name = "cmdline" },
		{ name = "buffer", keyword_length = 3 },
		{
			name = "dictionary",
			keyword_length = 2,
		},
	}),

})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "buffer" },
	}),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local cmp_window = require("cmp.utils.window")

function cmp_window:has_scrollbar()
	return false
end

-- local dict = require("cmp_dictionary")
-- dict.setup({
-- 	exact = 2,
-- 	max_items = 5000,
-- 	first_case_insensitive = true,
-- 	document = false,
-- 	document_command = "wn %s -over",
-- 	capacity = 5,
-- 	debug = false,
-- })
-- dict.switcher({
-- 	spelllang = {
-- 		en = vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt"), -- "/usr/share/dict/words"
-- 	},
-- })
-- dict.update()
