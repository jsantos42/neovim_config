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

-- Neovide
vim.g.neovide_theme = "auto"
vim.g.neovide_fullscreen = true
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<D-=>", function()
  change_scale_factor(1.1)
end)
vim.keymap.set("n", "<D-->", function()
  change_scale_factor(1 / 1.1)
end)
-- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
-- if vim.g.neovide then
--   vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
--   vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
--   vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
--   vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
-- end
--
-- -- Allow clipboard copy paste in neovim
-- vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})

vim.keymap.set(
    {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
    '<D-v>',
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
)
