-- Remove phpcs linter.
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      php = {},
      sql = { "sqruff" },
    },
  },
}
