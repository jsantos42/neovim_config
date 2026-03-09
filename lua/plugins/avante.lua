local is_online = vim.env.NVIM_ONLINE == "1"

return {
  {
    "saghen/blink.cmp",
    optional = true,
    enabled = is_online,
    specs = { "Kaiser-Yang/blink-cmp-avante" },
    opts = {
      sources = {
        default = { "avante" },
        providers = { avante = { module = "blink-cmp-avante", name = "Avante" } },
      },
    },
  },
  {
    "yetone/avante.nvim",
    enabled = is_online,
    build = "make",
    cmd = {
      "AvanteAsk",
      "AvanteChat",
      "AvanteToggle",
      "AvanteEdit",
      "AvanteBuild",
      "AvanteRefresh",
      "AvanteSwitchProvider",
    },
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      instructions_file = "avante.md",
      input = { provider = "snacks" },
      provider = "claude-code",
      -- ACP providers use the Claude Code CLI directly (stdin/stdout JSON-RPC),
      -- bypassing the need for an API key or proxy. Auth is handled by the CLI's
      -- own OAuth credentials (Max/Pro subscription).
      acp_providers = {
        ["claude-code"] = {
          command = "bunx",
          args = { "@zed-industries/claude-code-acp" },
          env = {
            HOME = os.getenv("HOME"),
            NODE_NO_WARNINGS = "1",
            ACP_PATH_TO_CLAUDE_CODE_EXECUTABLE = vim.fn.exepath("claude"),
            ACP_PERMISSION_MODE = "bypassPermissions",
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      -- "stevearc/dressing.nvim", -- for input provider dressing
      -- "folke/snacks.nvim", -- for input provider snacks
      -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
