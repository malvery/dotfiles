-- pack =======================================================================
vim.pack.add({
  'https://github.com/towolf/vim-helm',
  'https://github.com/sheerun/vim-polyglot',

  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',

  'https://github.com/rmagatti/auto-session',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/kazhala/close-buffers.nvim',

  'https://github.com/neovim/nvim-lspconfig',

  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',

  'https://github.com/dracula/vim',
})

-- tty ========================================================================

if not (vim.env.DISPLAY ~= nil or vim.env.WAYLAND_DISPLAY ~= nil or vim.env.COLORTERM ~= nil) then
  vim.cmd.colorscheme('desert')
else
  vim.cmd.colorscheme('dracula')
end

-- treesitter =================================================================
-- require 'nvim-treesitter'.setup {
--   ensure_installed = {
--     "bash",
--     "dockerfile",
--     "gotmpl",
--     "hcl",
--     "helm",
--     "html",
--     "javascript",
--     "json",
--     "lua",
--     "markdown",
--     "markdown_inline",
--     "python",
--     "regex",
--     "rego",
--     "sql",
--     "toml",
--     "vim",
--     "yaml",
--   },
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
--   indent = {
--     enable = true
--   }
-- }
--
-- vim.filetype.add({
--   extension = {
--     gotmpl = 'gotmpl',
--   },
--   pattern = {
--     [".*/templates/.*%.tpl"] = "helm",
--     [".*/templates/.*%.ya?ml"] = "helm",
--     ["helmfile.*%.ya?ml"] = "helm",
--   },
-- })

-- gitsigns ===================================================================
require('gitsigns').setup {}

-- telescope ==================================================================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
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

-- complete ===================================================================
vim.o.autocomplete = true

-- LSP config =================================================================
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { remap = false })

local servers = {
  "dockerls",
  "helm_ls",
  "pyright",
  "bashls",
  "terraformls",
  "yamlls",
  "ruff",
  "lua_ls",
}

for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
