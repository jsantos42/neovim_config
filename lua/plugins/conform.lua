local util = require("conform.util")
return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      php = { "php-cs-fixer" },
      blade = { "blade-formatter" },
      sql = { "sleek" },
      js = { "prettier" },
      ts = { "prettier" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },

      ["blade-formatter"] = {
        command = "blade-formatter",
        args = {
          "--write",
          "$FILENAME",
          "--wrap-line-length",
          9999,
          "--wrap-attributes",
          "preserve-aligned",
        },
        stdin = false,
      },

      ["php-cs-fixer"] = {
        command = "php-cs-fixer",
        args = {
          "fix",
          "--config",
          ".php-cs-fixer.dist.php",
          "$FILENAME",
        },
        stdin = false,
      },
    },
  },
}
