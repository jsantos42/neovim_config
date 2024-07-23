return {
  {
    "neovim/nvim-lspconfig",
    -- disable telemetry
    settings = { applicationInsights = false },
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change GoToDefinition keymap to open in new window
      keys[#keys + 1] = {
        "gd",
        function()
          require("telescope.builtin").lsp_definitions({ reuse_win = false, jump_type = "split" })
        end,
        -- "<cmd>split | lua vim.lsp.buf.definition()<CR>",
        desc = "Goto Definition",
        has = "definition",
      }
    end,
  },
}

-- In case I need to change the other GoTos
--       { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
--       { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
--       { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
--       { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
--     })
--   end,
-- },
