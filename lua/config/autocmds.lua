-- Autocmds are automatically loaded on the VeryLazy event

local function set_colorscheme()
  if vim.o.background == "light" then
    vim.cmd.colorscheme "vscode"
  else
    vim.cmd.colorscheme "vague"
  end
  -- Manually trigger the ColorScheme event to update UI components like bufferline
  vim.cmd "doautocmd ColorScheme"
end

-- Set the colorscheme on startup
set_colorscheme()

-- And update it whenever the 'background' option is changed
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = set_colorscheme,
})
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
