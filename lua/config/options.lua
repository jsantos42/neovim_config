-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set the statusline to show the current file name
vim.opt.winbar = "%=%m %t"

-- Set the textwidth to 80
vim.opt.textwidth = 80

-- Add resume Telescope search keymap
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)
