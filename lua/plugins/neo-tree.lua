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
      commands = {
        -- Sync neo-tree root changes to vim's cwd so file search/grep follow along
        set_root = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          if node.type ~= "directory" then
            path = vim.fn.fnamemodify(path, ":h")
          end
          require("neo-tree.sources.filesystem.commands").set_root(state)
          vim.fn.chdir(path)
        end,
        navigate_up = function(state)
          local parent = vim.fn.fnamemodify(state.path, ":h")
          require("neo-tree.sources.filesystem.commands").navigate_up(state)
          vim.fn.chdir(parent)
        end,
      },
    },
  },
}
