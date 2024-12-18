-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.del("n", "<S-h>")
-- vim.keymap.del("n", "<S-l>")

vim.api.nvim_set_keymap(
  "n",
  "<leader>dn",
  "<cmd>lua require'dap'.step_over()<CR>",
  { noremap = true, silent = true, desc = "Step Over" }
)

vim.keymap.del("n", "<leader>dO")
