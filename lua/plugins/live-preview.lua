return {
	{
		"brianhuster/live-preview.nvim",
		cmd = { "LivePreview" },
		config = function()
			local cfg = {
				sync_scroll = true,
				picker = "fzf-lua",
			}

			local start_preview

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

				start_preview = function(filepath)
					local port = pick_free_port()
					cfg.port = port
					require("livepreview.config").set(cfg)

					local lp = require("livepreview")
					local utils = require("livepreview.utils")
					local Config = require("livepreview.config").config
					local fs = vim.fs

					filepath = fs.normalize(filepath or vim.api.nvim_buf_get_name(0))
					if not lp.start(filepath, port) then
						return
					end

					local urlpath = Config.dynamic_root and fs.basename(filepath)
						or utils.get_relative_path(filepath, fs.normalize(vim.uv.cwd() or ""))
					local url = ("http://127.0.0.1:%d/%s"):format(port, vim.uri_encode(urlpath))
					vim.fn.setreg("+", url)
					vim.notify("Live preview URL copied!\nPaste into the browser.", vim.log.levels.INFO)
				end
			else
				start_preview = function(filepath)
					filepath = vim.fs.normalize(filepath or vim.api.nvim_buf_get_name(0))
					require("livepreview").start(filepath)
				end
			end

			require("livepreview.config").set(cfg)

			vim.api.nvim_create_user_command("LivePreview", function(opts)
				local sub = opts.fargs[1]
				if not sub or sub == "start" then
					start_preview(opts.fargs[2])
				elseif sub == "close" then
					require("livepreview").close()
				elseif sub == "pick" then
					require("livepreview").pick()
				else
					require("livepreview").help()
				end
			end, { force = true, nargs = "?" })
		end,
	},
}
