if vim.env.NVIM_NOTES == "1" then
	return {}
end

return {
	"avante-corp/avante.nvim",
	tag = "v0.1.2",
	build = "make",
	cmd = {
		"AvanteAsk",
		"AvanteChat",
		"AvanteChatNew",
		"AvanteToggle",
		"AvanteEdit",
		"AvanteBuild",
		"AvanteRefresh",
		"AvanteFocus",
		"AvanteSwitchProvider",
		"AvanteClear",
		"AvanteModels",
		"AvanteHistory",
		"AvanteStop",
	},
	opts = {
		provider = "ollama",
		providers = {
			ollama = {
				endpoint = "http://host.docker.internal:11435",
				model = "qwen3:8b",
				is_env_set = function() return true end,
				extra_request_body = {
					options = {
						temperature = 0.75,
						num_ctx = 20480,
					},
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = { file_types = { "markdown", "Avante" } },
			ft = { "markdown", "Avante" },
		},
	},
}
