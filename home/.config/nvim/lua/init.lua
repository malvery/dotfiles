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

-- auto-sessions ===========================================================
local opts = {
  auto_session_enable_last_session = false,
  auto_session_enabled = true,
  auto_save_enabled = false,
  auto_restore_enabled = true,
}

require('auto-session').setup(opts)

-- LSP =====================================================================
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD',	'<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',	'<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',	'<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi',	'<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr',	'<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d',	'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',	'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', '<leader>lsh',	'<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa',	'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr',	'<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl',	'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lD',		'<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr',		'<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>la',		'<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>le',		'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>lq',		'<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>lf",		'<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local nvim_lsp = require('lspconfig')
local servers = { "pylsp", "terraformls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 }
  }
end

nvim_lsp['efm'].setup{
	filetypes = { 'sh', 'json', "yaml" },
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 }
}

-- LSP completion ==========================================================
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
		nvim_lsp = true;
		path = true;
		buffer = true;
		tags = true;
	};
}

vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

