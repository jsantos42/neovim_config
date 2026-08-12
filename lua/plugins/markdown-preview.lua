return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function(plugin)
      local app = plugin.dir .. "/app"
      -- Use bun (available in container) with npm fallback
      local pm = vim.fn.executable("bun") == 1 and "bun" or "npm"
      vim.fn.system("cd " .. app .. " && " .. pm .. " install")
      -- Replace bundled mermaid with v11
      vim.fn.system(
        "cd "
          .. app
          .. " && "
          .. pm
          .. " install mermaid@latest"
          .. " && cp node_modules/mermaid/dist/mermaid.min.js _static/mermaid.min.js"
      )
      -- mermaid.init() was removed in v11, replace with mermaid.run()
      vim.fn.system(
        'sed -i \'s/mermaid\\.init(undefined,[^)]*)/"mermaid" in window \\&\\& mermaid.run({ querySelector: ".mermaid" })/\' '
          .. app
          .. "/pages/index.jsx"
      )
      -- hide the mermaid modifications from lazy.nvim's git status check
      -- NOTE: after a :Lazy restore, lazy.nvim resets the plugin to the locked
      -- commit, undoing these patches. Re-run the build manually with :Lazy build
      -- markdown-preview.nvim to restore mermaid v11 support.
      vim.fn.system(
        "git -C "
          .. plugin.dir
          .. " update-index --skip-worktree app/_static/mermaid.min.js app/pages/index.jsx app/package.json"
      )
      -- bun also writes app/bun.lock; keep it out of git's untracked list so
      -- lazy.nvim's dirty check stays clean.
      vim.fn.system("git -C " .. plugin.dir .. " check-ignore -q app/bun.lock || echo 'app/bun.lock' >> " .. plugin.dir .. "/.git/info/exclude")
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      if vim.env.NVIM_CONTAINERIZED == "1" then
        vim.g.mkdp_open_to_the_world = 1
        vim.g.mkdp_open_ip = "127.0.0.1"
        vim.cmd([[
          function! MarkdownPreviewOpenURL(url)
            let @+ = a:url
            lua vim.notify("Markdown preview URL copied!\nPaste into the browser.", vim.log.levels.INFO)
          endfunction
        ]])
        vim.g.mkdp_browserfunc = "MarkdownPreviewOpenURL"
      end
    end,
    config = function()
      if vim.env.NVIM_CONTAINERIZED ~= "1" then
        return
      end

      -- Find first available port in the mapped range (6670-6673) by
      -- attempting to bind+listen. At MarkdownPreview invocation time,
      -- any port already used by another instance's server will fail the
      -- probe, so we reliably pick a free one.
      local function pick_free_port()
        for p = 6670, 6673 do
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
        return 6670
      end

      -- Override the buffer-local MarkdownPreview command to pick a free
      -- port just before launching the server. The plugin defines these as
      -- buffer-local commands via s:init_command(), so we re-register them
      -- after the plugin's autocmd fires.
      -- The plugin registers buffer-local commands on BufEnter, so we must
      -- re-register ours after it. vim.schedule defers to after all current
      -- autocmds finish, ensuring we always win.
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        pattern = "*",
        callback = function(ev)
          if vim.bo[ev.buf].filetype ~= "markdown" then
            return
          end
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(ev.buf) then
              return
            end
            vim.api.nvim_buf_create_user_command(ev.buf, "MarkdownPreview", function()
              if vim.g.mkdp_clients_active == 0 then
                vim.g.mkdp_port = pick_free_port()
              end
              vim.fn["mkdp#util#open_preview_page"]()
            end, { force = true })
            vim.api.nvim_buf_create_user_command(ev.buf, "MarkdownPreviewToggle", function()
              if vim.g.mkdp_clients_active == 0 then
                vim.g.mkdp_port = pick_free_port()
              end
              vim.fn["mkdp#util#toggle_preview"]()
            end, { force = true })
          end)
        end,
      })
    end,
    ft = { "markdown" },
  },
}
