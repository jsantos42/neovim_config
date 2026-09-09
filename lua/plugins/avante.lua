if vim.env.NVIM_NOTES == "1" then
  return {}
end

return {
  "avante-corp/avante.nvim",
  tag = "v0.1.2",
  build = "make",
  cmd = {
    "AvanteAsk",
    "AvanteChat",
    "AvanteChatNew",
    "AvanteToggle",
    "AvanteEdit",
    "AvanteBuild",
    "AvanteRefresh",
    "AvanteFocus",
    "AvanteSwitchProvider",
    "AvanteClear",
    "AvanteModels",
    "AvanteHistory",
    "AvanteStop",
  },
  keys = {
    { "<leader>aa", "<Plug>(AvanteAsk)", desc = "Avante: Ask", mode = { "n", "v" } },
    { "<leader>an", "<Plug>(AvanteAskNew)", desc = "Avante: New ask", mode = { "n", "v" } },
    { "<leader>ae", "<Plug>(AvanteEdit)", desc = "Avante: Edit", mode = "v" },
    { "<leader>ar", "<Plug>(AvanteRefresh)", desc = "Avante: Refresh" },
    { "<leader>af", "<Plug>(AvanteFocus)", desc = "Avante: Focus" },
    { "<leader>at", "<Plug>(AvanteToggle)", desc = "Avante: Toggle" },
    { "<leader>aS", "<Plug>(AvanteStop)", desc = "Avante: Stop" },
    { "<leader>ac", "<cmd>AvanteClear<cr>", desc = "Avante: Clear" },
    { "<leader>ad", "<Plug>(AvanteToggleDebug)", desc = "Avante: Toggle debug" },
    { "<leader>as", "<Plug>(AvanteToggleSuggestion)", desc = "Avante: Toggle suggestion" },
    { "<leader>aR", "<Plug>(AvanteShowRepoMap)", desc = "Avante: Toggle repomap" },
    { "<leader>a?", "<Plug>(AvanteSelectModel)", desc = "Avante: Select model" },
    { "<leader>ah", "<Plug>(AvanteSelectHistory)", desc = "Avante: Select history" },
    { "<leader>aB", "<Plug>(AvanteAddAllBuffers)", desc = "Avante: Add all buffers" },
    { "co", "<Plug>(AvanteConflictOurs)", desc = "Avante: Choose ours", mode = { "n", "v" } },
    { "ct", "<Plug>(AvanteConflictTheirs)", desc = "Avante: Choose theirs", mode = { "n", "v" } },
    { "ca", "<Plug>(AvanteConflictAllTheirs)", desc = "Avante: Choose all theirs", mode = { "n", "v" } },
    { "cb", "<Plug>(AvanteConflictBoth)", desc = "Avante: Choose both", mode = { "n", "v" } },
    { "cc", "<Plug>(AvanteConflictCursor)", desc = "Avante: Choose cursor", mode = { "n", "v" } },
    { "]x", "<Plug>(AvanteConflictNextConflict)", desc = "Avante: Next conflict" },
    { "[x", "<Plug>(AvanteConflictPrevConflict)", desc = "Avante: Prev conflict" },
  },
  opts = {
    mode = "legacy",
    provider = "ollama",
    cursor_applying_provider = "ollama",
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = true,
      jump_result_buffer_on_finish = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
      enable_token_counting = true,
      use_cwd_as_project_root = false,
      auto_focus_on_diff_view = false,
    },
    providers = {
      ollama = {
        endpoint = "http://host.docker.internal:11435",
        model = "qwen3:8b",
        disable_tools = true,
        is_env_set = function()
          return true
        end,
        extra_request_body = {
          options = {
            temperature = 0.5,
            num_ctx = 12288,
            num_predict = 4096,
          },
          think = false,
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
