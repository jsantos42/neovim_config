-- Pin nvim-treesitter to the last commit supporting Neovim 0.11.
-- The main branch dropped 0.11 support in c82bf96f (2026-04-01),
-- which broke parser installation silently (vim.list.unique is 0.12+ only).
return {
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "7caec274fd19c12b55902a5b795100d21531391f",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = "851e865342e5a4cb1ae23d31caf6e991e1c99f1e",
	},
}
