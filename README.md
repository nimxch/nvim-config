# nimxch/nvim

Personal Neovim config. Leader key: `Space`.

## Install

```bash
git clone <this-repo> ~/.config/nvim
nvim  # lazy.nvim bootstraps itself, then :Lazy sync
```

After first launch install LSP servers:
```
:MasonInstall jdtls java-debug-adapter java-test debugpy delve
```
`pyright` and `gopls` install automatically.

---

## File Explorer

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle nvim-tree |
| `<leader>t` | Focus nvim-tree |

---

## Finding Things (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |
| `<leader>ft` | Search TODOs |

---

## Buffers / Tabs

| Key | Action |
|-----|--------|
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |
| `<leader>bd` | Close buffer |

---

## LSP (Python · Go · Java/Spring Boot)

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
| `<leader>fm` | Format buffer |

Java extras: `<leader>oi` organize imports · `<leader>rv` extract variable · `<leader>rm` extract method

**Install servers:** `:Mason` opens the UI. `:LspInfo` shows active servers for the current buffer.

---

## Debugging (DAP)

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
| `<leader>dt` | Debug nearest test (Python/Go) |
| `<leader>dT` | Debug last test (Python/Go) |

Debug UI opens/closes automatically when a session starts/ends.

---

## Git

| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>hb` | Toggle inline blame |

---

## Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `<leader>th` | Open horizontal terminal |
| `<Esc>` (in terminal) | Exit to normal mode |

---

## Editing

| Key | Action |
|-----|--------|
| `gcc` | Comment/uncomment line |
| `gc` | Comment selection (visual) |
| `ys<motion><char>` | Add surround — e.g. `ysiw"` wraps word in `""` |
| `cs<old><new>` | Change surround — e.g. `cs"'` |
| `ds<char>` | Delete surround |
| `<leader>s` | Search & replace word under cursor |

---

## Diagnostics / Problems

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle problems panel |
| `<leader>xd` | Document diagnostics |
| `<leader>xw` | Workspace diagnostics |
| `<leader>l` | Run linter manually |

---

## Misc

| Key | Action |
|-----|--------|
| `<leader><leader>` | Re-source current file |
| `<C-f>` | Open tmux-sessionizer |
| `<C-d>` / `<C-u>` | Scroll down/up (cursor centered) |
| `J` / `K` (visual) | Move selected lines down/up |

Press `Space` and pause — **which-key** shows all available bindings.

---

## Structure

```
lua/nimxch/
├── init.lua          # entry point
├── lazy.lua          # plugin manager bootstrap
├── setup.lua         # vim options
├── keymaps.lua       # global keymaps
├── lsp/              # LSP server configs
│   ├── init.lua      # shared on_attach + capabilities
│   ├── python.lua    # pyright settings
│   ├── go.lua        # gopls settings
│   └── java.lua      # jdtls config builder
└── plugins/          # one file per plugin
    └── lsp/          # LSP + DAP plugin specs
```
