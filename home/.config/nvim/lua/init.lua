-- treesitter =================================================================
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "dockerfile",
    "gotmpl",
    "hcl",
    "helm",
    "html",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "rego",
    "sql",
    "toml",
    "vim",
    "yaml",
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

-- telescope ==================================================================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fm', builtin.marks)
vim.keymap.set('n', '<leader>fs', builtin.spell_suggest)

-- auto-sessions ==============================================================
require('auto-session').setup({
  auto_session_enable_last_session = false,
  auto_session_enabled = true,
  auto_save_enabled = false,
  auto_restore_enabled = false,
})

-- blink.cmp ==================================================================
require('blink.cmp').setup({
  keymap    = { preset  = 'enter' },
  signature = { enabled = true },

  completion = {
    list = {
      selection = {
        preselect = false,
      },
    }
  }
})

-- LSP config =================================================================
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { remap = false })

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text      = false,
    signs             = true,
    underline         = true,
    update_in_insert  = false,
  }
)

local servers = {
  "dockerls",
  "helm_ls",
  "pyright",
  "bashls",
  "terraformls",
  "yamlls",
  "ruff",
}

for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
