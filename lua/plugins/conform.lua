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

local function blade_warning(root, version)
  return vim.fs.basename(root)
    .. ": vendor Pint "
    .. version
    .. " predates --blade (needs >= 1.30), so Blade files are not formatted. Run: composer update laravel/pint"
end

local function warn_about_old_pint(root, version)
  vim.notify_once(blade_warning(root, version), vim.log.levels.WARN)
  return false
end

local function supports_blade(ctx)
  local root = pint_project_root(ctx)
  local version = vendor_pint_version(root)
  return not lacks_blade_support(version) or warn_about_old_pint(root, version)
end

local function pint_args(ctx, extra_args)
  local has_config = vim.uv.fs_stat(pint_project_root(ctx) .. "/pint.json") ~= nil
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
