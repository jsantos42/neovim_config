return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = vim.env.NVIM_NOTES ~= "1",
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
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      if vim.env.NVIM_CONTAINERIZED == "1" then
        vim.g.mkdp_open_to_the_world = 1
        vim.g.mkdp_open_ip = "127.0.0.1"
        vim.g.mkdp_port = 8089
        vim.cmd([[
          function! MarkdownPreviewOpenURL(url)
            let @+ = a:url
            lua vim.notify("Markdown preview URL copied!\nPaste into the browser.", vim.log.levels.INFO)
          endfunction
        ]])
        vim.g.mkdp_browserfunc = "MarkdownPreviewOpenURL"
      end
    end,
    ft = { "markdown" },
  },
}
