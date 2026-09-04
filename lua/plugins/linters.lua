-- Remove phpcs linter.
if vim.env.NVIM_NOTES == "1" then
	return {
		{
			"mfussenegger/nvim-lint",
			optional = true,
			opts = {
				linters_by_ft = {
					markdown = {},
				},
			},
		},
	}
end

return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      php = {},
      sql = { "sqruff" },
      markdown = {},
    },
  },
}
