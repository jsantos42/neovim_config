-- Container-aware Mason configuration.
--
-- On the host (non-containerized), Mason works normally — mason-lspconfig
-- auto-installs LSP servers and LazyVim extras manage ensure_installed.
--
-- In the Docker container (NVIM_CONTAINERIZED=1):
--
-- 1. mason-lspconfig is disabled. LSP servers, formatters, and linters are
--    pre-installed in the Docker image (via bun, go, pip, composer). LazyVim
--    falls back to setting up servers directly via nvim-lspconfig, which
--    finds the binaries in PATH.
--
-- 2. Mason's ensure_installed is overridden using an opts function (not a
--    plain table). This matters because LazyVim language extras (go, php,
--    typescript, etc.) each append their tools (gofumpt, phpcs, shfmt, ...)
--    to ensure_installed during plugin setup. An opts function runs AFTER all
--    that merging, so it can replace the accumulated list with only the
--    packages that genuinely need Mason — debug adapters and JARs that can't
--    be baked into the Docker image. Without this override, Mason would
--    redundantly install ~20 tools that are already in the image, causing
--    race conditions and slow startup.

local is_containerized = vim.env.NVIM_CONTAINERIZED == "1"

return {
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = not is_containerized,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if is_containerized then
        opts.ensure_installed = {
          "js-debug-adapter",
          "php-debug-adapter",
          "java-debug-adapter",
          "java-test",
        }
      end
    end,
  },
}
