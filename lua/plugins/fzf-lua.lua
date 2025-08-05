return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    config = function()
      local base_rg_opts = [[--color=never --hidden --no-heading --line-number --column --smart-case --multiline ]]
        .. [[-g "!.git" ]]
        .. [[-g "!.idea" ]]
        .. [[-g "!.vscode" ]]
        .. [[-g "!build" ]]
        -- .. [[-g "!**/vendor/*" ]]
        .. [[-g "!vendor" ]]
        .. [[-g "!dist" ]]
        .. [[-g "!**/yarn.lock" ]]
        .. [[-g "!**/package-lock.json" ]]
        .. [[-g "!node_modules" ]]
        .. [[-g "!bladecache" ]]
        .. [[-g "!**/composer.lock" ]]
        .. [[-g "!*min.js*" ]]
        .. [[-g "!gulp.log" ]]
        .. [[-g "!**/init.sql" ]]

      require("fzf-lua").setup({
        winopts = {
          height = 1,
          width = 1,
        },
        files = {
          formatter = "path.filename_first",
          fd_opts = [[--color=never --hidden --type f --type l ]]
            .. [[--exclude "**/.git" ]]
            .. [[--exclude "**/.idea" ]]
            .. [[--exclude "**/.vscode" ]]
            .. [[--exclude "**/build/*" ]]
            .. [[--exclude "**/vendor/*" ]]
            .. [[--exclude "**/dist/*" ]]
            .. [[--exclude "**/yarn.lock" ]]
            .. [[--exclude "**/package-lock.json" ]]
            .. [[--exclude "*min.js*" ]]
            .. [[--exclude "*gulp.log" ]]
            .. [[--exclude "**/node_modules/*" ]],
        },
        grep = {
          rg_opts = base_rg_opts,
        },
        oldfiles = {
          include_current_session = true,
        },
      })

      vim.keymap.set("n", "<leader>sG", function()
        require("fzf-lua").live_grep({
          cwd = vim.fn.expand("%:p:h"),
        })
      end, { silent = true, desc = "Fzf Grep (Current Dir)" })

      vim.keymap.set("n", "<leader>sl", function()
        require("fzf-lua").live_grep({
          rg_opts = base_rg_opts .. " --fixed-strings",
        })
      end, { silent = true, desc = "Fzf Literal Grep" })

      vim.keymap.set("n", "<leader>sL", function()
        require("fzf-lua").live_grep({
          cwd = vim.fn.expand("%:p:h"),
          rg_opts = base_rg_opts .. " --fixed-strings",
        })
      end, { silent = true, desc = "Fzf Literal Grep (Current Dir)" })
    end,
  },

  -- For searching for multiple lines literally, select them in visual mode and use <leader>sw
}
