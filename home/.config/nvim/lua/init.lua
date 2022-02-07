-- treesitter =================================================================
--[[ require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
} ]]

-- gitsigns ===================================================================
require('gitsigns').setup {
  signs = {
      add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '!', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~_', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    }
}

-- HOP ========================================================================
require'hop'.setup()

-- commenter ==================================================================
vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default<CR>", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default<C-c>", {})

require('kommentary.config').configure_language("terraform", {
    single_line_comment_string = "#",
    prefer_single_line_comments = true,
})

require('kommentary.config').configure_language("helm", {
    single_line_comment_string = "#",
    prefer_single_line_comments = true,
})

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
  documentation = false,
  experimental = { native_menu = true }
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(
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

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', '<leader>lsh',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lwa',  '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr',  '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwl',  '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr',   '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>la',   '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>le',   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>lq',   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>lf",   '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local nvim_lsp = require('lspconfig')
local servers = { "pylsp", "terraformls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach     = on_attach,
    flags         = { debounce_text_changes = 150 },
    capabilities  = capabilities
  }
end

nvim_lsp['yamlls'].setup{
  filetypes     = { 'yaml' },
  on_attach     = on_attach,
  flags         = { debounce_text_changes = 150 },
  capabilities  = capabilities
}

nvim_lsp['efm'].setup{
  filetypes     = { 'sh', 'json' },
  on_attach     = on_attach,
  flags         = { debounce_text_changes = 150 },
  capabilities  = capabilities,
  root_dir      = nvim_lsp.util.root_pattern{".git/", "."}
}
