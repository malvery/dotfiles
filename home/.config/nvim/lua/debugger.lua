-- hotkeys =================================================================
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)

vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dS", ":lua require'dap'.disconnect()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dR", ":lua require'dap'.run_last()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", opts)

-- adapters ================================================================
local dap = require('dap')
dap.adapters.python = {
  type    = 'executable';
  command = 'python3';
  args    = { '-m', 'debugpy.adapter' };
}

-- UI ======================================================================
require("dapui").setup()

-- configurations ==========================================================
dap.configurations.python = {
  {
    type        = 'python';
    request     = 'launch';
    name        = "Launch file";
    program     = "${file}";
    justMyCode  = false;
  }
}

