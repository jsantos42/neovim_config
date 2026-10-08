# CLAUDE.md

This is a Neovim configuration repository built on LazyVim.

## Tech stack

- **Lua** -- all configuration is in Lua
- **lazy.nvim** -- plugin manager
- **LazyVim** -- base distribution with curated defaults and extras
- **stylua** -- Lua formatter (config in `stylua.toml`)

## Project layout

- `init.lua` -- entry point, just loads `config.lazy`
- `lua/config/` -- core settings: options, keymaps, autocmds, lazy.nvim bootstrap
- `lua/plugins/` -- one file per plugin or plugin group, each returns a lazy.nvim plugin spec table
- `lazyvim.json` -- exists for LazyVim compatibility but extras are managed in Lua (see `lua/plugins/lazy-extras.lua`)
- `queries/blade/` -- tree-sitter queries for Blade template syntax
- `snippets/` -- JSON snippet files (SQL, Blade)

## Conventions

- Plugin specs go in `lua/plugins/` as individual files returning a table (or list of tables)
- Tabs are used for indentation (tabstop=4, noexpandtab) -- enforced in `options.lua`
- Format Lua with `stylua` (uses `stylua.toml` at repo root)
- Environment-conditional features check `NVIM_ONLINE`, `NVIM_CONTAINERIZED`, and `NVIM_NOTES` env vars
- LazyVim extras are declared in `lua/plugins/lazy-extras.lua` (not `lazyvim.json`) so they can be conditional on `NVIM_NOTES`. `:LazyExtras` toggle is non-functional — edit the Lua file directly.
- LSP servers that phone home are disabled/configured for offline use (see `lspconfig.lua` and recent commits)
- Mason tool installation is handled differently in containers vs native (see `mason.lua`)

## Key design decisions

- Root detection prioritizes `.git` over LSP over cwd (`vim.g.root_spec` in options)
- Swap/backup files are disabled -- git is the safety net
- Completion (blink.cmp) can be toggled at runtime with `<leader>uk`
- Colorscheme auto-switches between dark (vague.nvim) and light (vscode.nvim) based on `vim.o.background`
- fzf-lua syncs its search root with neo-tree's current directory
- Markdown preview (markdown-preview.nvim) is enabled unconditionally across all modes
- Notes mode (`NVIM_NOTES=1`) is markdown-only — no orgmode, no csvview
- PHP: conform's `pint` (project `vendor/bin/pint` first, global fallback) formats PHP and Blade (`pint_blade`, `--blade`) from the project root, adding `--preset=psr12` only when there's no `pint.json`. nvim-lint runs `mago_lint` (with the `emacs` report format — Mago 1.52's `short` format embeds ANSI colours) and `phpstan` only where `vendor/bin/phpstan` exists. Tools come from the dev-env image. When the project's installed Pint (from `vendor/composer/installed.json`) is older than 1.30, `pint_blade` is skipped and `vim.notify_once` warns once per project. `pint_blade` is likewise skipped with a warning when the project has a `tailwind.config.*` but no `node_modules/tailwindcss` (Pint's `prettier-plugin-tailwindcss` would fail to load the config)

## Testing changes

Open Neovim and verify the config loads without errors:

```sh
nvim --headless "+lua print('ok')" +qa
```
