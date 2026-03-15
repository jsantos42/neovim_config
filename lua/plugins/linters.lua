-- Remove phpcs linter.
return {
  "mfussenegger/nvim-lint",
  optional = true,
  enabled = vim.env.NVIM_NOTES ~= "1",
  opts = {
    linters_by_ft = {
      php = {},
      sql = { "sqruff" },
    },
  },
}
