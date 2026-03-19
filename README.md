# Neovim Config

A personalized Neovim configuration built on [LazyVim](https://lazyvim.github.io/), managed with [lazy.nvim](https://github.com/folke/lazy.nvim). Designed to work both natively and inside containers, with optional AI assistance and Neovide GUI support.

## Features

- **LazyVim base** with curated extras for TypeScript, Python, Go, PHP, Java, SQL, YAML, JSON, and Docker
- **Notes mode** -- `NVIM_NOTES=1` disables dev extras for a lightweight markdown-focused setup
- **Container-aware** -- OSC 52 clipboard, conditional mason setup, online/offline mode toggle (`NVIM_ONLINE`, `NVIM_CONTAINERIZED` env vars)
- **AI integration** via [avante.nvim](https://github.com/yetone/avante.nvim) backed by Claude Code (activates when `NVIM_ONLINE=1`)
- **PHP/Blade** first-class support -- Intelephense LSP, tree-sitter highlighting/injections, blade-formatter, XDebug debugging with Docker path mappings
- **Database tooling** -- vim-dadbod + UI + completions, comprehensive SQL snippets
- **Neovide support** -- fullscreen, auto theme, scaling keybinds, macOS option-key handling, system paste

## Structure

```
init.lua                    Entry point -- loads config.lazy
lua/
  config/
    lazy.lua                lazy.nvim bootstrap & LazyVim setup
    options.lua             Vim options (tabs, swap, wrap, clipboard, ...)
    keymaps.lua             Custom keybindings (DAP, motions, Neovide paste)
    autocmds.lua            Auto light/dark colorscheme switching
  plugins/
    lazy-extras.lua         LazyVim extras & notes plugins (conditional on NVIM_NOTES)
    lspconfig.lua           LSP servers (vtsls, intelephense, html, css, tailwind, pyright, sqls, yaml)
    mason.lua               Mason config (container-aware)
    blink.lua               Completion engine (blink.cmp) with toggle
    conform.lua             Formatting (prettier, php-cs-fixer, blade-formatter, sqruff)
    linters.lua             Linting (sqruff)
    fzf-lua.lua             Fuzzy finder with custom grep/search mappings
    neo-tree.lua            File tree with cwd sync and relative path copy
    avante.lua              Claude Code AI assistant
    colorscheme.lua         vague.nvim (dark) / vscode.nvim (light)
    test.lua                Neotest with Jest & Vitest adapters
    blade.lua               Blade template support
    multicursor.lua         Multi-cursor editing (vim-visual-multi)
    nvim-dap-ui.lua         Debug adapter UI
    mason-nvim-dap.lua      DAP adapters (PHP/XDebug, JS, Java)
    markdown-preview.lua    Markdown preview
queries/blade/              Tree-sitter queries for Blade templates
snippets/                   SQL and Blade snippet libraries
```

## Notable keybindings

All LazyVim defaults apply. Additional custom mappings:

| Key | Mode | Action |
|-----|------|--------|
| `<leader>dn` | n | DAP step over |
| `<leader>tl` | n | Run last test |
| `<leader>tL` | n | Debug last test |
| `<leader>tw` | n | Run test in watch mode |
| `<leader>uk` | n | Toggle completion |
| `<leader>sG` | n | Grep (current directory) |
| `<leader>sl` | n | Literal grep |
| `0` | n | First non-blank character (like `^`) |
| `<D-=>` / `<D-->` | n | Neovide zoom in/out |
| `<D-v>` | all | Paste in Neovide |

## Environment variables

| Variable | Effect |
|----------|--------|
| `NVIM_ONLINE=1` | Enables AI features (avante.nvim) |
| `NVIM_CONTAINERIZED=1` | Switches to OSC 52 clipboard, adjusts mason |
| `NVIM_NOTES=1` | Disables dev extras (LSPs, DAP, testing, formatters, linters); markdown-focused mode |

### LazyVim extras managed in Lua (not lazyvim.json)

Extras are declared in `lua/plugins/lazy-extras.lua` instead of `lazyvim.json` so they can be conditionally disabled in notes mode. This means **`:LazyExtras` toggle no longer controls them** — the UI still displays all available extras, but toggling writes to `lazyvim.json` which is ignored. To add or remove extras, edit `lazy-extras.lua` directly.

### OSC 52 clipboard in containers

When running Neovim inside a container (or over SSH), there is no X11 or Wayland display server available, so the system clipboard doesn't work. This config detects `NVIM_CONTAINERIZED=1` and enables the **OSC 52** escape sequence protocol instead. OSC 52 lets the terminal application running inside the container send clipboard data directly to your host terminal emulator, bypassing the need for a display server entirely.

For this to work, your terminal emulator must have OSC 52 support enabled:

- **iTerm2**: Go to *Preferences > General > Selection* and check **"Applications in terminal may access clipboard"**
- **macOS Terminal.app**: Not supported -- use iTerm2 or another terminal

Once enabled, yanking text in Neovim inside the container will copy it to your host system clipboard, and pasting from the host clipboard will work as expected.

## Notes mode (local, non-containerised)

A lightweight markdown note-taking mode. Add to `~/.zshrc`:

```bash
alias notes='NVIM_NOTES=1 nvim ~/Documents/notes'
```

### What changes in notes mode

- All dev extras disabled (LSPs, DAP, testing, formatters, linters, lang extras)
- Mason disabled
- Treesitter limited to markdown, lua, vim, vimdoc, query, bash, regex

## Requirements

- Neovim >= 0.10
- A Nerd Font for icons
- For AI features: [Claude Code](https://claude.ai/claude-code) CLI
- For notes mode: no additional requirements

## License

Apache 2.0 -- see [LICENSE](LICENSE).
