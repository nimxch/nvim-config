# nimxch/nvim

A personal Neovim config built on [lazy.nvim](https://github.com/folke/lazy.nvim), set up for
**Java (+ Spring Boot)**, **Python**, **TypeScript/JavaScript**, and **Rust** development, with
LSP, debugging (DAP), formatting, linting, git integration, fuzzy-finding, and a
[Catppuccin](https://github.com/catppuccin/nvim) (Mocha) theme.

Leader key: `Space`.

## Table of Contents

- [What's Included](#whats-included)
- [Prerequisites](#prerequisites)
- [Install](#install)
  - [Linux](#linux)
  - [macOS](#macos)
  - [Windows](#windows)
- [First Launch](#first-launch)
- [How to Use Neovim](#how-to-use-neovim)
- [Keybindings](#keybindings)
- [Structure](#structure)
- [Known Quirks](#known-quirks)

---

## What's Included

| Area | Tool(s) |
|------|---------|
| Plugin manager | lazy.nvim |
| Java LSP | nvim-jdtls (jdtls), + Spring Boot bundle for live hover/run-configs/bean navigation in `.java` files |
| Spring Boot properties/YAML | standalone boot-ls (property key completion/validation in `application.properties`/`.yml`) |
| Python LSP | pyright |
| TypeScript/JavaScript LSP | ts_ls (typescript-language-server) |
| Rust LSP | rust-analyzer |
| Autocompletion | blink.cmp (LSP, path, snippet, buffer sources; Rust-accelerated fuzzy matching) |
| Debugging (DAP) | nvim-dap + nvim-dap-ui + nvim-dap-virtual-text; debugpy (Python), jdtls's built-in adapter (Java) |
| Formatting | conform.nvim (stylua, prettierd/prettier, black, rustfmt, shfmt), synchronous format-on-save |
| Linting | nvim-lint (eslint_d, pylint, shellcheck) |
| Fuzzy finder | telescope.nvim (+ telescope-fzf-native for a faster sorter) |
| File explorer | nvim-tree.lua (netrw disabled in favor of this) |
| Git | gitsigns.nvim (hunks) + git-blame.nvim (inline blame) |
| Syntax | nvim-treesitter (`main` branch) |
| Theme | catppuccin/nvim, flavour `mocha`, accent retinted to Flamingo |
| Statusline / tabs | lualine.nvim / bufferline.nvim |
| Terminal | toggleterm.nvim |
| Diagnostics panel | trouble.nvim |
| QoL | nvim-autopairs, Comment.nvim, nvim-surround, indent-blankline.nvim, todo-comments.nvim, vim-illuminate, which-key.nvim, alpha.nvim (dashboard) |

---

## Prerequisites

These are needed regardless of OS. Platform-specific install commands are in the next section.

| Tool | Why |
|------|-----|
| **Neovim >= 0.11** | This config uses the native `vim.lsp.config()`/`vim.lsp.enable()` API added in 0.11 (tested on 0.12.2). |
| **git** | Clones this config and is used by lazy.nvim to fetch plugins. |
| **A C compiler** (`cc`/`clang`/`gcc`) | Needed to compile treesitter parsers. |
| **`tree-sitter` CLI** | The `nvim-treesitter` `main` branch shells out to the `tree-sitter` CLI to build parsers — this is a *separate binary* from the C compiler above. Without it you'll see `ENOENT: no such file or directory (cmd): 'tree-sitter'`. |
| **ripgrep (`rg`)** | Telescope's live grep (`<leader>fg`) depends on it directly. |
| **`fd`** *(optional)* | Speeds up Telescope's find-files (`<leader>ff`); falls back to `find`/`rg --files` without it. |
| **`make`** | Builds `telescope-fzf-native`'s native sorter. |
| **A Nerd Font** | Needed for the icons in bufferline, lualine, nvim-tree, and the alpha dashboard to render instead of showing boxes/`?`. Set it as your terminal's font after installing. |

### Per-language toolchains

| Language | Needs |
|----------|-------|
| Java | JDK 17+ (jdtls's requirement), Maven or Gradle for real projects |
| Python | `python3` |
| TypeScript/JavaScript | Node.js + npm (Mason installs `ts_ls`, `prettierd`, `eslint_d` via npm) |
| Rust | `rustup` (installs `cargo`/`rustc`; `rustfmt` and `clippy` come by default) |

---

## Install

This repo lives at `~/.config/nvim` (Linux/macOS) or `%LOCALAPPDATA%\nvim` (Windows). Clone it
there — if you're setting this up on a new machine and this repo has no remote yet, push it to
one (GitHub, etc.) first, then clone from there instead of copying files by hand.

### Linux

```bash
# Debian/Ubuntu — apt's neovim package is usually too old; use the unstable PPA
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim git ripgrep fd-find make build-essential

# tree-sitter CLI has no apt package on most distros — install via npm or cargo
npm install -g tree-sitter-cli    # or: cargo install tree-sitter-cli

# Java
sudo apt install openjdk-21-jdk maven

# Python
sudo apt install python3 python3-pip

# TypeScript/JavaScript (NodeSource, for a current LTS — apt's nodejs is often stale too)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs

# Rust
curl https://sh.rustup.rs -sSf | sh

# Arch, for reference:
#   sudo pacman -S neovim git ripgrep fd tree-sitter-cli make jdk-openjdk maven \
#                  python nodejs npm rustup

# Nerd Font — download one from https://www.nerdfonts.com/font-downloads,
# unzip into ~/.local/share/fonts, then: fc-cache -fv
```

```bash
git clone <your-repo-url> ~/.config/nvim
nvim
```

### macOS

```bash
brew install neovim git tree-sitter-cli ripgrep fd make
brew install --cask font-jetbrains-mono-nerd-font   # or any other Nerd Font

# Java
brew install openjdk@21 maven

# Python
brew install python3

# TypeScript/JavaScript
brew install node

# Rust
curl https://sh.rustup.rs -sSf | sh
```

```bash
git clone <your-repo-url> ~/.config/nvim
nvim
```

### Windows

**Recommended: WSL2.** jdtls, rust-analyzer, and the various CLI formatters/linters are far more
reliable in a Linux-like environment. Install WSL2 with an Ubuntu distro (`wsl --install`), then
follow the [Linux instructions](#linux) *inside* WSL — your config still lives at `~/.config/nvim`
inside the WSL filesystem, and a Windows Terminal profile pointed at your WSL distro gives you a
normal terminal.

**Native Windows** (if you'd rather not use WSL), via [winget](https://learn.microsoft.com/windows/package-manager/winget/):

```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install Microsoft.VisualStudio.2022.BuildTools   # provides a C compiler (cl.exe)

# tree-sitter CLI — no winget package; install via npm or cargo instead
npm install -g tree-sitter-cli    # or: cargo install tree-sitter-cli

# Java
winget install EclipseAdoptium.Temurin.21.JDK
winget install Apache.Maven

# Python
winget install Python.Python.3.12

# TypeScript/JavaScript
winget install OpenJS.NodeJS.LTS

# Rust
winget install Rustlang.Rustup
```

Nerd Font: download a font from [nerdfonts.com](https://www.nerdfonts.com/font-downloads),
double-click each `.ttf`/`.otf` file and choose **Install**, then set it as the font for your
terminal profile (Windows Terminal → Settings → Profile → Appearance → Font face).

```powershell
git clone <your-repo-url> $env:LOCALAPPDATA\nvim
nvim
```

---

## First Launch

1. Start `nvim`. `lua/nimxch/lazy.lua` bootstraps lazy.nvim automatically on first run and
   installs every plugin — this can take a minute.
2. If anything looks incomplete afterward, run `:Lazy sync`.
3. Install the LSP servers/tools that aren't auto-installed (jdtls is managed by nvim-jdtls
   rather than mason-lspconfig, and a few DAP/formatter/linter binaries are Mason packages too,
   but not wired into `ensure_installed` — see `lua/nimxch/plugins/lsp/mason.lua`):
   ```vim
   :MasonInstall jdtls java-debug-adapter java-test spring-boot-tools debugpy black prettierd eslint_d pylint shellcheck
   ```
   `pyright`, `ts_ls`, and `rust_analyzer` install automatically via mason-lspconfig.
4. `:checkhealth` to catch anything environment-specific (missing Nerd Font glyphs, missing
   `rg`/`fd`, clipboard provider, etc.).

---

## How to Use Neovim

If you're new to modal editing, here's the minimum to get moving in this config.

**Modes.** Neovim starts in **Normal mode** (for navigating/editing commands, not typing text).
Press `i` to enter **Insert mode** and type text; `<Esc>` (or `<C-c>`, mapped the same here)
returns to Normal mode. `v` enters **Visual mode** to select text character-by-character, `V` for
whole lines. `:` enters **Command mode** for one-off commands like `:w` or `:q`.

**Moving around (Normal mode).** `h`/`j`/`k`/`l` move left/down/up/right. `w`/`b` jump
word-forward/backward. `gg`/`G` jump to the top/bottom of the file. `0`/`$` jump to the
start/end of the line. Prefix any motion with a count — `5j` moves down 5 lines. Relative line
numbers are on in this config specifically to make counted motions easy to read.

**Basic editing.** `x` deletes a character, `dd` deletes (cuts) a line, `yy` copies (yanks) a
line, `p` pastes after the cursor. `u` undoes, `<C-r>` redoes. `o`/`O` open a new line
below/above and drop you into Insert mode.

**Saving and quitting.** `:w` saves, `:q` quits, `:wq` (or `ZZ` in Normal mode) saves and quits,
`:q!` quits without saving.

**The leader key and which-key.** Most custom shortcuts in this config are prefixed with
`<leader>`, mapped to `Space`. Press `Space` and pause — **which-key** pops up a menu of every
available follow-up key and what it does, so you don't need to memorize the full table below to
get started.

**A typical first workflow in this config:**
1. `nvim .` from a project directory to open it.
2. `<leader>e` to open the file tree, or `<leader>ff` to fuzzy-find a file directly.
3. Open a file — the matching LSP server attaches automatically (Java/Python/TypeScript/Rust).
4. `gd` to jump to a definition, `K` to see docs, `<leader>ca` for a code action.
5. `<leader>fm` to format on demand (or just save — format-on-save is on).
6. `<C-\>` to pop a floating terminal for running the project without leaving Neovim.

---

## Keybindings

The full reference also lives in `KEYBINDINGS.md`. Buffer-local LSP keymaps below only apply
once a server has attached to the current buffer; a smaller set of the same keys (`gd`, `K`,
`<leader>rn`, `<leader>f`) work everywhere as fallbacks even with no LSP attached (see
`lua/nimxch/keymaps.lua`).

### File Explorer

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle nvim-tree |
| `<leader>t` | Focus nvim-tree |

### Finding Things (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |
| `<leader>ft` | Search TODO/FIXME/HACK/etc. comments (todo-comments.nvim) |

### Buffers / Tabs

| Key | Action |
|-----|--------|
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |
| `<leader>bd` | Close buffer |

### LSP (Java/Spring Boot · Python · TypeScript · Rust)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `gi` | Implementation |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>D` | Type definition |
| `[d` / `]d` | Prev/next diagnostic |
| `<leader>q` | Send buffer diagnostics to the location list |
| `<leader>fm` | Format buffer (conform.nvim; also runs automatically on save) |

> **Note:** a separate `<leader>f` (no `m`) is also mapped as a plain `vim.lsp.buf.format`
> fallback for buffers with no LSP attached (see `keymaps.lua`). Because it shares a prefix with
> `<leader>ff`/`<leader>fg`/etc., pressing `<leader>f` and pausing fires the fallback formatter;
> pressing `<leader>f` immediately followed by another letter routes to Telescope/conform instead.

**Java/Spring Boot extras:** `<leader>oi` organize imports · `<leader>rv` extract variable ·
`<leader>rm` extract method.

`application.properties`/`.yml` files get their own completion/validation from the standalone
Spring Boot properties LS — no extra keybinding, it just attaches automatically inside
Maven/Gradle projects.

**Install servers:** `:Mason` opens the UI. `:LspInfo` shows active servers for the current buffer.

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start / continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>du` | Toggle debug UI |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Re-run last session |
| `<leader>dt` | Debug nearest test (Python only) |
| `<leader>dT` | Debug last test (Python only) |

Debug UI opens/closes automatically when a session starts/ends. Java debugging (breakpoints,
step commands) works through jdtls's built-in adapter, but there's no `<leader>dt`/`dT`-style
test-runner keymap wired up for it yet, even though the `java-test` Mason package is loaded.

### Git

| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>hb` | Toggle inline current-line blame (gitsigns; git-blame.nvim's own blame text is always on) |

### Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `<leader>th` | Open horizontal terminal |
| `<Esc>` (in terminal) | Exit to normal mode |

### Editing

| Key | Action |
|-----|--------|
| `gcc` | Comment/uncomment line |
| `gc` | Comment selection (visual) |
| `ys<motion><char>` | Add surround — e.g. `ysiw"` wraps word in `""` |
| `cs<old><new>` | Change surround — e.g. `cs"'` |
| `ds<char>` | Delete surround |
| `<leader>s` | Search & replace word under cursor |

### Clipboard

| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | Normal / Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `<leader>p` | Visual | Paste over selection without clobbering clipboard |
| `<leader>d` | Normal / Visual | Delete to void register (doesn't overwrite clipboard) |

### Quickfix / Location List

| Key | Action |
|-----|--------|
| `<C-k>` | Next quickfix item |
| `<C-j>` | Previous quickfix item |
| `<leader>k` | Next location list item |
| `<leader>j` | Previous location list item |

### Diagnostics / Problems

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle problems panel (trouble.nvim) |
| `<leader>xd` | Document diagnostics |
| `<leader>xw` | Workspace diagnostics |
| `<leader>l` | Run linter manually (nvim-lint; also runs on save/read) |

### Misc

| Key | Action |
|-----|--------|
| `<leader><leader>` | Re-source current file |
| `<C-f>` | Open tmux-sessionizer |
| `<C-d>` / `<C-u>` | Scroll down/up (cursor centered) |
| `J` / `K` (visual) | Move selected lines down/up |
| `J` (normal) | Join line below without moving the cursor |
| `n` / `N` | Next/prev search match (centered) |
| `Q` | Disabled (prevents accidentally entering Ex mode) |

Press `Space` and pause — **which-key** shows all available bindings.

---

## Structure

```
lua/nimxch/
├── init.lua          # entry point (requires lazy, setup, keymaps in order)
├── lazy.lua           # plugin manager bootstrap
├── setup.lua          # vim.opt editor settings
├── keymaps.lua        # global keymaps
├── lsp/                # LSP server config modules (settings + config builders)
│   ├── init.lua        # shared on_attach + capabilities
│   ├── python.lua       # pyright settings
│   ├── typescript.lua   # ts_ls settings
│   ├── rust.lua         # rust-analyzer settings
│   ├── java.lua         # jdtls config builder (incl. Spring Boot bundle)
│   └── spring_boot.lua  # standalone Spring Boot properties/YAML LS config
└── plugins/            # one file per plugin (lazy.nvim spec)
    └── lsp/            # LSP/DAP plugin specs
        ├── mason.lua        # mason.nvim + mason-lspconfig
        ├── dap.lua          # nvim-dap core + UI + keymaps (language-agnostic)
        ├── python.lua       # ts_ls/pyright wiring + nvim-dap-python
        ├── typescript.lua   # ts_ls wiring
        ├── rust.lua         # rust-analyzer wiring
        ├── java.lua         # nvim-jdtls plugin spec
        └── spring_boot.lua  # standalone Spring Boot LS plugin spec
```

---

## Known Quirks

- **`tree-sitter` CLI is a separate install from a C compiler.** If you see
  `ENOENT: no such file or directory (cmd): 'tree-sitter'`, you have a compiler but not the CLI —
  install it via your package manager, `npm install -g tree-sitter-cli`, or
  `cargo install tree-sitter-cli`.
- **`<leader>f` vs `<leader>ff`/`<leader>fm`.** See the note under [LSP](#lsp-javaspring-boot--python--typescript--rust) above — they're deliberately different bindings that happen to share a prefix.
- **Java test bundle loaded but unused.** `java-test` is loaded into jdtls's bundles (see
  `lua/nimxch/lsp/java.lua`) but no keymap currently calls into it.
- **blink.cmp's Rust fuzzy matcher downloads on first real (non-headless) launch.** If
  `:Lazy build blink.cmp` doesn't finish downloading the prebuilt binary before you start typing,
  it falls back to the pure-Lua matcher automatically (`fuzzy.implementation =
  "prefer_rust_with_warning"`) — completion still works, just slightly slower until the download
  completes.
