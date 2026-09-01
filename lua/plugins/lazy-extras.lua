-- LazyVim extras — managed here instead of lazyvim.json so we can
-- conditionally disable dev extras in notes mode (NVIM_NOTES=1).
--
-- IMPORTANT: Because extras are declared in Lua, the :LazyExtras UI
-- toggle no longer controls them. The UI will still display all available
-- extras, but toggling will write to lazyvim.json which is now ignored.
-- To add/remove extras, edit this file directly.

local is_notes = vim.env.NVIM_NOTES == "1"

-- Dev extras — disabled in notes mode
local dev_extras = {
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.php" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.sql" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
}

-- Notes-only plugins
local notes_plugins = {
  { import = "lazyvim.plugins.extras.lang.markdown" },
  -- Override LazyVim's default treesitter ensure_installed (which includes jsonc
  -- and other dev parsers that aren't bundled or needed in notes mode)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "regex",
      }
    end,
  },
}

if is_notes then
  return notes_plugins
else
  return dev_extras
end
