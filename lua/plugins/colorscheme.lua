local function set_colorscheme()
  if vim.o.background == "light" then
    vim.cmd.colorscheme "vscode"
  else
    vim.cmd.colorscheme "vague"
  end
end

return {
  { "vague2k/vague.nvim", priority = 1000 },
  { "Mofiqul/vscode.nvim", priority = 1000 },
  {
    "LazyVim/LazyVim",
    config = function()
      set_colorscheme()

      vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "background",
        callback = set_colorscheme,
      })
    end,
  },
}
