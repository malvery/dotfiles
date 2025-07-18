-- treesitter =================================================================
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "lua",
    "python",
    "hcl",
    "yaml",
    "vim",
    "gotmpl", "helm",
    "json",
    "regex",
    "rego",
    "toml",
    "markdown", "markdown_inline"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}

vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- gitsigns ===================================================================
require('gitsigns').setup {}

-- auto-sessions ==============================================================
local opts = {
  auto_session_enable_last_session = false,
  auto_session_enabled = true,
  auto_save_enabled = false,
  auto_restore_enabled = false,
}

require('auto-session').setup(opts)

-- nvim-cmp ===================================================================
local cmp = require'cmp'

cmp.setup({
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end
        }
      }
  }),
  window = {
    documentation = cmp.config.disable
  },
  view = {
    entries = "native"
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

-- LSP config =================================================================
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text      = false,
    signs             = true,
    underline         = true,
    update_in_insert  = false,
  }
)

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[d',          '<cmd>lua vim.diagnostic.goto_prev()<CR>',  opts)
vim.api.nvim_set_keymap('n', ']d',          '<cmd>lua vim.diagnostic.goto_next()<CR>',  opts)
vim.api.nvim_set_keymap('n', '<leader>le',  '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lq',  '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  buf_set_keymap('n', '<leader>lsh',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa',  '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr',  '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl',  '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr',   '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>la',   '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap("n", "<leader>lf",   '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
end

local nvim_lsp = require('lspconfig')

local servers = { "pyright", "terraformls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach     = on_attach,
    flags         = { debounce_text_changes = 150 },
    capabilities  = capabilities
  }
end

-- local servers = { "pyright", "terraformls" }
-- for _, lsp in ipairs(servers) do
--   vim.lsp.enable(lsp)
-- end

nvim_lsp['yamlls'].setup{
  filetypes     = { 'yaml' },
  on_attach     = on_attach,
  flags         = { debounce_text_changes = 150 },
  capabilities  = capabilities
}

nvim_lsp['bashls'].setup{
  filetypes     = { 'sh' },
  on_attach     = on_attach,
  flags         = { debounce_text_changes = 150 },
  capabilities  = capabilities
}

nvim_lsp['dockerls'].setup {
  on_attach     = on_attach,
  flags         = { debounce_text_changes = 150 },
  capabilities  = capabilities
}

nvim_lsp['helm_ls'].setup {
  on_attach     = on_attach,
  flags         = { debounce_text_changes = 150 },
  capabilities  = capabilities
}

nvim_lsp['efm'].setup{
  filetypes     = { 'sh', 'python' },
  on_attach     = on_attach,
  flags         = { debounce_text_changes = 150 },
  capabilities  = capabilities,
  root_dir      = nvim_lsp.util.root_pattern{".git/", "."}
}
