-- https://cmp.saghen.dev/installation.html
return {
  "saghen/blink.cmp",
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    keymap = {
      preset = "super-tab",
    },
    enabled = function()
      return vim.g.blink_cmp_enabled == true
    end,
  },
  init = function()
    vim.g.blink_cmp_enabled = true
    vim.keymap.set("n", "<leader>uk", function()
      vim.g.blink_cmp_enabled = not vim.g.blink_cmp_enabled
      vim.notify("Autocompletion " .. (vim.g.blink_cmp_enabled and "enabled" or "disabled"))
    end, { desc = "Toggle autocompletion" })
  end,
}
