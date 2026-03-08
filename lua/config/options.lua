-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set the statusline to show the current file name
vim.opt.winbar = "%f%m %="

-- Set the textwidth to 80
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.wrapscan = false

-- Disable swap/backup files — rely on git instead of recovery files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Briefly flash the matching bracket when typing a closing ), ] or }
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Let h, l and arrow keys wrap to the previous/next line at line boundaries
-- vim.opt.whichwrap:append("<,>,h,l")

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

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- OSC 52 clipboard for terminal nvim in container (no X11/Wayland available)
-- Requires terminal emulator OSC 52 support (iTerm2: Preferences > General >
-- Selection > "Applications in terminal may access clipboard")
if vim.env.NVIM_CONTAINERIZED and not vim.g.neovide then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
