-- treesitter =============================================================
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true
	},
}

-- commenter ===============================================================
vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default<CR>", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default<C-c>", {})

-- LSP =====================================================================
require'lspconfig'.pylsp.setup{}
require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = true;

	source = {
		path = true;
		nvim_lsp = true;
	};
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

