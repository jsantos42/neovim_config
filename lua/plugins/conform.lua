if vim.env.NVIM_NOTES == "1" then
  return {
    {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters_by_ft = {
          markdown = { "prettier" },
        },
      },
    },
  }
end

local function pint_project_root(ctx)
  local marker = vim.fs.find({ "pint.json", "composer.json" }, { upward = true, path = ctx.dirname })[1]
  return marker and vim.fs.dirname(marker) or ctx.dirname
end

local function read_installed_packages(root)
  local ok, lines = pcall(vim.fn.readfile, root .. "/vendor/composer/installed.json")
  local installed = ok and vim.json.decode(table.concat(lines, "\n")) or {}
  return installed.packages or installed
end

local function vendor_pint_version(root)
  local pint = vim.iter(read_installed_packages(root)):find(function(pkg)
    return pkg.name == "laravel/pint"
  end)
  return pint and pint.version
end

local function lacks_blade_support(version)
  local major, minor = (version or ""):match("^v?(%d+)%.(%d+)")
  return major ~= nil and (tonumber(major) < 1 or (tonumber(major) == 1 and tonumber(minor) < 30))
end

local TAILWIND_CONFIGS = { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts" }

local function has_file(root, name)
  return vim.uv.fs_stat(root .. "/" .. name) ~= nil
end

-- prettier-plugin-tailwindcss loads the project's Tailwind config, which fails without its node_modules
local function lacks_tailwind_install(root)
  local has_config = vim.iter(TAILWIND_CONFIGS):any(function(name)
    return has_file(root, name)
  end)
  return has_config and not has_file(root, "node_modules/tailwindcss")
end

local function old_pint_warning(root, version)
  return vim.fs.basename(root)
    .. ": vendor Pint "
    .. version
    .. " predates --blade (needs >= 1.30), so Blade files are not formatted. Run: composer update laravel/pint"
end

local function missing_tailwind_warning(root)
  return vim.fs.basename(root)
    .. ": Tailwind config found but node_modules/tailwindcss is missing, so Blade files are not formatted."
    .. " Install the project's JS dependencies (e.g. bun install / npm install)"
end

local function blade_skip_reason(root)
  local version = vendor_pint_version(root)
  local old_pint = lacks_blade_support(version) and old_pint_warning(root, version)
  return old_pint or (lacks_tailwind_install(root) and missing_tailwind_warning(root)) or nil
end

local function warn_and_skip(message)
  vim.notify_once(message, vim.log.levels.WARN)
  return false
end

local function supports_blade(ctx)
  local reason = blade_skip_reason(pint_project_root(ctx))
  return reason == nil or warn_and_skip(reason)
end

local function pint_args(ctx, extra_args)
  local has_config = has_file(pint_project_root(ctx), "pint.json")
  local preset_args = has_config and {} or { "--preset=psr12" }
  return vim.list_extend(vim.list_extend(preset_args, extra_args), { "$FILENAME" })
end

return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      php = { "pint" },
      blade = { "pint_blade" },
      sql = { "sqruff" }, --INFO: if there's an error in the file (trailing comma for example), the formatting goes wrong
      js = { "prettier" },
      ts = { "prettier" },
      markdown = { "prettier" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },

      pint = {
        cwd = function(_, ctx)
          return pint_project_root(ctx)
        end,
        args = function(_, ctx)
          return pint_args(ctx, {})
        end,
      },

      pint_blade = {
        inherit = "pint",
        condition = function(_, ctx)
          return supports_blade(ctx)
        end,
        cwd = function(_, ctx)
          return pint_project_root(ctx)
        end,
        args = function(_, ctx)
          return pint_args(ctx, { "--blade" })
        end,
      },
    },
  },
}
