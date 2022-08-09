local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
--local map_cmd = bind.map_cmd
require("keymap.config")

local plug_map = {
	-- bufferline
	["n|gb"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
	["n|<C-j>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
	["n|<C-k>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
	-- Plugin nvim-tree
	["n|<C-n>"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
	["n|<C-f>"] = map_cr("NvimTreeFocus"):with_noremap():with_silent(),
	-- lsp
	["n|K"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(), -- show doc modal
	["n|gr"] = map_cr("Lspsaga rename"):with_noremap():with_silent(), -- show rename modal
	["n|gf"] = map_cr("Lspsaga lsp_finder"):with_noremap():with_silent(), -- show finder modal
	["n|gd"] = map_cr("Lspsaga preview_definition"):with_noremap():with_silent(), -- show define modal
	["n|e["] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent(), -- jump next err
	["n|e]"] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent(), -- jump prev err
	["n|gs"] = map_cr("Lspsaga signature_help"):with_noremap():with_silent(), -- function signature
	--["n|<leader>ca"] = map_cr("Lspsaga code_action"):with_noremap():with_silent(), -- use saga show code action
	["n|<leader>ca"] = map_cu("lua vim.lsp.buf.code_action()"):with_noremap():with_silent(), -- use telescope show code action
	["n|gD"] = map_cr("lua vim.lsp.buf.definition()"):with_noremap():with_silent(), -- show definition
	--["n|gh"] = map_cr("lua vim.lsp.buf.references()"):with_noremap():with_silent(), -- show references
	["n|gh"] = map_cr("lua require('telescope.builtin').lsp_references()"):with_noremap():with_silent(), -- show references
	-- telescope
	["n|<Leader>f"] = map_cu("Telescope"):with_noremap():with_silent(),
	["n|<Leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent(),
	["n|<Leader>fp"] = map_cu("lua require('telescope').extensions.project.project{}"):with_noremap():with_silent(),
	["n|<Leader>fr"] = map_cu("lua require('telescope').extensions.frecency.frecency{}"):with_noremap():with_silent(),
	["n|<Leader>fw"] = map_cu("Telescope live_grep"):with_noremap():with_silent(),
	-- undo
	["n|<Leader>u"] = map_cr("UndotreeToggle"):with_noremap():with_silent(),
	-- hop
	["n|<leader>w"] = map_cu("HopWord"):with_noremap(),
	["n|<leader>j"] = map_cu("HopLine"):with_noremap(),
	["n|<leader>c"] = map_cu("HopChar1"):with_noremap(),
	["n|<leader>cc"] = map_cu("HopChar2"):with_noremap(),
	-- Plugin auto_session
	["n|<leader>ss"] = map_cu("SaveSession"):with_noremap():with_silent(),
	["n|<leader>sr"] = map_cu("RestoreSession"):with_noremap():with_silent(),
	["n|<leader>sd"] = map_cu("DeleteSession"):with_noremap():with_silent(),
	-- Plugin Diffview
	["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap(),
	["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap(),
	-- dap
	["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_noremap():with_silent(),
}

bind.nvim_load_mapping(plug_map)
