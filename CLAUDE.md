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
- `lazyvim.json` -- declares which LazyVim extras are enabled
- `queries/blade/` -- tree-sitter queries for Blade template syntax
- `snippets/` -- JSON snippet files (SQL, Blade)

## Conventions

- Plugin specs go in `lua/plugins/` as individual files returning a table (or list of tables)
- Tabs are used for indentation (tabstop=4, noexpandtab) -- enforced in `options.lua`
- Format Lua with `stylua` (uses `stylua.toml` at repo root)
- Environment-conditional features check `NVIM_ONLINE` and `NVIM_CONTAINERIZED` env vars
- LSP servers that phone home are disabled/configured for offline use (see `lspconfig.lua` and recent commits)
- Mason tool installation is handled differently in containers vs native (see `mason.lua`)

## Key design decisions

- Root detection prioritizes `.git` over LSP over cwd (`vim.g.root_spec` in options)
- Swap/backup files are disabled -- git is the safety net
- Completion (blink.cmp) can be toggled at runtime with `<leader>uk`
- Colorscheme auto-switches between dark (vague.nvim) and light (vscode.nvim) based on `vim.o.background`
- fzf-lua syncs its search root with neo-tree's current directory

## Testing changes

Open Neovim and verify the config loads without errors:
```sh
nvim --headless "+lua print('ok')" +qa
```
