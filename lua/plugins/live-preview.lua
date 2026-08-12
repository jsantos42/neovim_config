return {
	{
		"brianhuster/live-preview.nvim",
		cmd = { "LivePreview" },
		config = function()
			local cfg = {
				sync_scroll = true,
				picker = "fzf-lua",
			}

			if vim.env.NVIM_CONTAINERIZED == "1" then
				cfg.address = "0.0.0.0"
				cfg.browser = "echo"

				local function pick_free_port()
					for p = 6674, 6677 do
						local sock = vim.uv.new_tcp()
						local ok = sock:bind("0.0.0.0", p)
						if ok == 0 then
							local lok = sock:listen(1, function() end)
							sock:close()
							if lok == 0 then
								return p
							end
						else
							sock:close()
						end
					end
					return 6674
				end

				vim.api.nvim_create_user_command("LivePreviewStart", function()
					local port = pick_free_port()
					cfg.port = port
					require("livepreview.config").set(cfg)
					vim.cmd("LivePreview start")
					vim.schedule(function()
						local relpath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
						local url = ("http://127.0.0.1:%d/%s"):format(port, relpath)
						vim.fn.setreg("+", url)
						vim.notify("Live preview URL copied!\nPaste into the browser.", vim.log.levels.INFO)
					end)
				end, {})
			end

			require("livepreview.config").set(cfg)
		end,
	},
}
