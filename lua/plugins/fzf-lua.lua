return {
  {
    "ibhagwan/fzf-lua",
    config = function()
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
            .. [[--exclude "**/node_modules/*" ]],
        },
        grep = {
          rg_opts = [[--color=never --hidden --no-heading --line-number --column --smart-case ]]
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
            .. [[-g "!*min.js" ]]
            .. [[-g "!**/init.sql" ]],
        },
      })
    end,
  },
}
