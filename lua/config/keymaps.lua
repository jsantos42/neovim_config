-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.del("n", "<S-h>")
-- vim.keymap.del("n", "<S-l>")

 if vim.g.neovide then
   vim.g.neovide_input_macos_option_key_is_meta = "only_left"
 end

vim.api.nvim_set_keymap(
  "n",
  "<leader>dn",
  "<cmd>lua require'dap'.step_over()<CR>",
  { noremap = true, silent = true, desc = "Step Over" }
)

vim.keymap.del("n", "<leader>dO")

-- Preserve view position during undo/redo
vim.keymap.set("n", "u", function()
  local view = vim.fn.winsaveview()
  vim.cmd("normal! u")
  vim.fn.winrestview(view)
end, { desc = "Undo without moving cursor" })

vim.keymap.set("n", "<C-r>", function()
  local view = vim.fn.winsaveview()
  vim.cmd("normal! \x12") -- \x12 is Ctrl-R
  vim.fn.winrestview(view)
end, { desc = "Redo without moving cursor" })

-- Allow paste in neovide
vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<D-v>", function()
  vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end, { noremap = true, silent = true })
