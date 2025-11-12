return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      window = {
        mappings = {
          -- Override the yank path commands to use relative paths
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local relative_path = vim.fn.fnamemodify(filepath, ":.")
              vim.fn.setreg("+", relative_path)
              vim.notify("Copied relative path: " .. relative_path)
            end,
            desc = "Copy relative path",
          },
        },
      },
    },
  },
}
