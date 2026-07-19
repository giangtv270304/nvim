# Neovim Config (LazyVim)

Personal Neovim configuration built on top of [LazyVim](https://www.lazyvim.org/), tuned for
Go / TypeScript / DevOps (Terraform, Ansible, Docker, Kubernetes YAML) work, with keymaps that
also work inside VSCode via the `vscode-neovim` extension.

## Requirements

Install these before first launch (macOS / Homebrew shown, adjust for your OS):

| Tool | Why | Install |
|------|-----|---------|
| Neovim >= 0.10 | editor itself | `brew install neovim` |
| git | plugin manager clones from GitHub | `brew install git` |
| A [Nerd Font](https://www.nerdfonts.com/) | icons in statusline/explorer/completion | `brew install --cask font-jetbrains-mono-nerd-font` (set it as your terminal font) |
| ripgrep | Telescope live grep | `brew install ripgrep` |
| fd | faster file listing | `brew install fd` |
| A C compiler (Xcode CLT) | builds `telescope-fzf-native` and Treesitter parsers | `xcode-select --install` |
| lazygit | `<leader>gg` opens it in a floating terminal | `brew install lazygit` |
| Node.js | required by several Mason-installed LSP servers (`ts_ls`, `eslint`, `prettier(d)`) | `brew install node` |
| Go | only if you edit Go and want `gopls`/`gofumpt`/`goimports` to install cleanly | `brew install go` |

Everything else (LSP servers, formatters, linters) is installed automatically by
[Mason](https://github.com/mason-org/mason.nvim) — see [`lua/plugins/lsp.lua`](lua/plugins/lsp.lua).

## Fresh machine install

```bash
# 1. back up an existing config, if any
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# 2. clone this repo into place
git clone git@github.com:giangtv270304/nvim.git ~/.config/nvim

# 3. launch nvim — lazy.nvim bootstraps itself and installs every plugin
nvim
```

On first launch, `lazy.nvim` clones itself, installs all plugins pinned in
[`lazy-lock.json`](lazy-lock.json), and `mason-tool-installer` installs LSP servers, formatters,
and linters in the background. Restart Neovim once that finishes (watch the notifications, or
run `:Lazy` / `:Mason` to check status).

## Structure

```
init.lua                 -- sets leader key, requires config.lazy
lua/config/
  options.lua             -- editor options (indent, search, UI, diagnostics)
  keymaps.lua             -- custom keymaps layered on top of LazyVim defaults
  autocmds.lua            -- filetype detection (Dockerfile, Ansible, Terraform...), yank highlight, trim trailing whitespace
  lazy.lua                -- bootstraps lazy.nvim and loads the plugin spec
lua/plugins/              -- one file per plugin/feature (LSP, telescope, git, tests, UI...)
lazyvim.json              -- enabled LazyVim extras (currently: vscode)
lazy-lock.json            -- pinned plugin commits — keep this committed for reproducible installs
KEYMAPS.md                -- full keymap reference
```

## Highlights

- **Picker:** Telescope · **Explorer:** neo-tree · **Completion:** nvim-cmp
  (pinned explicitly in `lua/config/options.lua` so LazyVim doesn't switch to its newer
  snacks-based defaults).
- **LSP/format/lint:** auto-installed via Mason — Go, TypeScript/JavaScript, Terraform, Ansible,
  Docker(-compose), YAML/JSON, Bash, Markdown, Lua.
- **Git:** gitsigns (hunk staging/preview/blame), diffview, and lazygit (`<leader>gg`).
- **Testing:** neotest, mapped under `<leader>T` (capital T, so it doesn't collide with the
  tab/terminal `<leader>t` maps).
- **VSCode Neovim support:** `lazyvim.json` enables `lazyvim.plugins.extras.vscode`, and
  `lua/plugins/vscode.lua` maps the same LazyVim-style keys to native VSCode commands when
  Neovim is embedded in VSCode (via `asvetliakov.vscode-neovim`). Everything else in this repo
  behaves the same whether you're in a terminal or in VSCode.

## Keymaps

Leader is `Space`. See [`KEYMAPS.md`](KEYMAPS.md) for the full reference, or press `<leader>fk`
inside Neovim to fuzzy-search all active keymaps.
