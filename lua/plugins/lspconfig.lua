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
      },
    },
  },
}

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
