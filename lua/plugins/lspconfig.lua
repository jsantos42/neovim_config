return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- @type lspconfig.options
      servers = {
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = false,
            },
          },
        },
        intelephense = {
          filetypes = { "php", "blade" },
          init_options = {
            licenceKey = "foo", -- add your actual licenseKey
          },
        },
        html = {
          filetypes = { "html", "php", "blade" },
        },
        cssls = {},
        somesass_ls = {
          settings = {
            somesass = {
              suggestAllFromOpenDocument = false,
            },
          },
        },
        sqls = {},
      },
    },
  },
}

--------------------------------------------------------------------------------
--INFO: Regarding the SQL LSP server "sqls-server/sqls", you will need to add a
-- config file in ~/.config/sqls/config.yml with the following:
-- lowercaseKeywords: false
-- connections:
--   - alias: go
--     driver: postgresql
--     dataSourceName: host=127.0.0.1 port=5432 user=postgres password=postgres dbname=postgres sslmode=disable
--
-- You might also need to specify on the .sql file which connection you want to use:
-- -- sqls:connection go
--
-- You might also need to install the "nanotee/sqls.nvim" plugin that works as
-- the LSP client:
-- return {
--   "nanotee/sqls.nvim",
--   ft = { "sql" },
-- }
--------------------------------------------------------------------------------

-- -- Disable inlay hints in case error keeps popping up
-- return {
--   {
--     "nvim-lspconfig",
--     opts = {
--       inlay_hints = { enabled = false },
--     },
--   },
-- }

-- -- Change GoToDefinition keymap to open in new window
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = function()
--       local keys = require("lazyvim.plugins.lsp.keymaps").get()
--       keys[#keys + 1] = {
--         "gd",
--         function()
--           require("telescope.builtin").lsp_definitions({ reuse_win = false, jump_type = "split" })
--         end,
--         -- "<cmd>split | lua vim.lsp.buf.definition()<CR>",
--         desc = "Goto Definition",
--         has = "definition",
--       }
--     end,
--   },
-- }

-- In case I need to change the other GoTos
--       { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
--       { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
--       { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
--       { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
--     })
--   end,
-- },

-- Last alternative: to opt out of vtsls and use typescript-language-server
--https://github.com/LazyVim/LazyVim/issues/3465#issuecomment-2225218341
