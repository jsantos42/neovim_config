-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set the statusline to show the current file name
vim.opt.winbar = "%f%m %="

-- Set the textwidth to 80
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.wrapscan = false

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.lazyvim_php_lsp = "intelephense"

vim.o.tabstop = 4
vim.o.expandtab = false
vim.o.shiftwidth = 0
vim.o.relativenumber = false
vim.g.codeium_enabled = false

vim.g.root_spec = {
  { ".git" },
  "lsp",
  "cwd",
}

vim.g.neovide_theme = "auto"
