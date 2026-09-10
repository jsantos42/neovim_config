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

-- gemma4:26b cannot follow Avante's edit protocol — it hallucinates tool
-- calls and claims success without modifying files. Use qwen3_6 instead.

-- ============================================================================
-- UPGRADE NOTES: v0.1.2 -> v0.2.3 (latest as of 2026-09-10)
-- ============================================================================
--
-- BREAKING CHANGES requiring config migration:
--   1. cursor_applying_provider was removed — delete that line from opts.
--   2. Shared libraries moved — run :AvanteBuild after first launch.
--   3. Default mode is now "agentic" (our explicit mode = "legacy" still works).
--   4. vendors key deprecated — we already use providers, so no issue.
--   5. require("avante_lib").load() deprecated — auto-discovered after :AvanteBuild.
--
-- OLLAMA-SPECIFIC CHANGES:
--   - Ollama is now a first-class built-in provider with dedicated backend code.
--   - New defaults: num_ctx=20480, keep_alive="5m".
--   - New use_ReAct_prompt option (default true for Ollama) enables XML-based tool
--     calls in text output. Moot with disable_tools = true.
--   - is_env_set override still valid. Default now pings the endpoint; hardcoding
--     true avoids startup latency for remote/Docker endpoints.
--   - disable_tools (bool, per-provider) vs disabled_tools (list, global top-level):
--     the latter selectively disables specific tools by name.
--   - Consider adding keep_alive = "5m" and timeout = 30000 to provider config.
--
-- OLLAMA AGENTIC MODE STATUS (still broken):
--   Multiple issues (#2938, #2830, #2093, #2048) report infinite tool-calling loops,
--   UI freezes, and tools detected but never executed with models from 7B to 70B.
--   Maintainers closed several as "not planned" — considered a model limitation.
--   Our mode = "legacy" + disable_tools = true is the community-recommended approach.
--   Legacy mode has no concrete deprecation plans despite the name (#1956, closed stale).
--
-- KNOWN REGRESSIONS TO WATCH:
--   - #2694: num_ctx settings may be ignored with Ollama (always defaults to 20480).
--   - #2557/#2165: :AvanteModels / <leader>a? model picker doesn't display Ollama models.
--
-- NOTABLE NEW FEATURES:
--   - ACP (Agent Client Protocol): integrate external agents (Claude Code, Gemini CLI)
--     via JSON-RPC. The real answer for agentic work with local models — keep Ollama for
--     legacy queries, delegate tool-heavy tasks to a capable external agent.
--   - Zen/CLI mode (contrib/avante): Claude Code-like terminal experience.
--   - Project instructions: avante.md file per project (like CLAUDE.md).
--   - /model in-chat command: switch models mid-conversation.
--   - Memory summarization: manage context windows for long conversations.
--   - RAG service: project-wide retrieval-augmented generation.
--   - Token count display in the sidebar.
--   - Loading performance optimizations in v0.2.1.
--
-- UPGRADE STEPS (if unpinning):
--   1. Change tag = "v0.1.2" to tag = "v0.2.3" (or remove for HEAD).
--   2. Remove cursor_applying_provider = "ollama" from opts.
--   3. Keep mode = "legacy" and disable_tools = true.
--   4. Optionally add keep_alive = "5m" and timeout = 30000 to ollama provider.
--   5. Run :AvanteBuild after first launch.
--   6. Confirm Neovim >= 0.11.0.
--
-- REFERENCES:
--   - Provider migration: github.com/yetone/avante.nvim/wiki/Provider-configuration-migration-guide
--   - Ollama provider docs: mintlify.wiki/yetone/avante.nvim/providers/ollama
--   - Agentic vs Legacy: deepwiki.com/yetone/avante.nvim/11.4-interaction-modes
-- ============================================================================
