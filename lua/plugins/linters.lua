-- PHP: mago lint + phpstan (where the project has it) instead of LazyVim's phpcs.
if vim.env.NVIM_NOTES == "1" then
  return {
    {
      "mfussenegger/nvim-lint",
      optional = true,
      opts = {
        linters_by_ft = {
          markdown = {},
        },
      },
    },
  }
end

local function find_upward(name, dirname)
  return vim.fs.find(name, { upward = true, path = dirname })[1]
end

-- Mago 1.52's "short" format embeds ANSI colours even with --colors=never, breaking nvim-lint's
-- built-in parser, so lint with the plain "emacs" format instead.
local mago_emacs_parser = function()
  return require("lint.parser").from_pattern(
    "[^:]+:(%d+):(%d+):(%l+) %- ([%w-]+): (.+)",
    { "lnum", "col", "severity", "code", "message" },
    {
      error = vim.diagnostic.severity.ERROR,
      warning = vim.diagnostic.severity.WARN,
      note = vim.diagnostic.severity.INFO,
      help = vim.diagnostic.severity.HINT,
    },
    { source = "mago_lint" }
  )
end

return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      php = { "mago_lint", "phpstan" },
      sql = { "sqruff" },
      markdown = {},
    },
    linters = {
      mago_lint = {
        args = { "--colors=never", "lint", "--reporting-format=emacs" },
        parser = mago_emacs_parser(),
        condition = function()
          return vim.fn.executable("mago") == 1
        end,
      },
      phpstan = {
        cmd = function()
          return find_upward("vendor/bin/phpstan", vim.fn.expand("%:p:h"))
        end,
        condition = function(ctx)
          return find_upward("vendor/bin/phpstan", ctx.dirname) ~= nil
        end,
      },
    },
  },
}
