return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = vim.env.NVIM_NOTES ~= "1",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
