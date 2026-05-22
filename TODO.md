# Neovim → VSCode Parity TODO

## Current Setup
| Plugin | Purpose |
|--------|---------|
| tokyonight.nvim | Theme |
| lualine.nvim | Status bar |
| nvim-treesitter | Syntax parsing |
| telescope.nvim | Fuzzy finder |
| git-blame.nvim | Inline blame |
| gitsigns.nvim | Gutter diff markers + hunk actions |
| nvim-tree.nvim | File explorer |
| bufferline.nvim | VSCode-style tab bar |
| toggleterm.nvim | Integrated terminal |
| which-key.nvim | Keybinding popup |
| conform.nvim | Format on save |
| nvim-lint | Linting |
| nvim-autopairs | Auto-close brackets |
| Comment.nvim | `gcc` / `gc` commenting |
| nvim-surround | Surround text objects |
| indent-blankline.nvim | Indent guide lines |
| trouble.nvim | Problems panel |
| todo-comments.nvim | TODO/FIXME highlights |
| alpha.nvim | Start screen dashboard |
| vim-illuminate | Highlight word under cursor |
| nvim-web-devicons | Icons |
| plenary.nvim | Utility lib |

---

## TODO

### Critical (broken without these)

- [x] **nvim-tree plugin file** — created `plugins/nvim-tree.lua`
- [ ] **LSP** — zero language intelligence right now *(user will configure manually)*
  - `neovim/nvim-lspconfig` — LSP client config
  - `williamboman/mason.nvim` — install LSP servers from inside nvim (like VSCode extensions)
  - `williamboman/mason-lspconfig.nvim` — bridge mason ↔ lspconfig
- [ ] **Autocompletion** — depends on LSP *(user will configure manually)*
  - `hrsh7th/nvim-cmp` — completion engine
  - `hrsh7th/cmp-nvim-lsp` — LSP source for cmp
  - `hrsh7th/cmp-buffer` — current buffer words
  - `hrsh7th/cmp-path` — filesystem paths
- [ ] **Snippets** — depends on LSP setup *(user will configure manually)*
  - `L3MON4D3/LuaSnip` — snippet engine
  - `saadparwaiz1/cmp_luasnip` — LuaSnip source for cmp
  - `rafamadriz/friendly-snippets` — pre-built snippet collection

---

### High Priority (VSCode feel)

- [x] **gitsigns.nvim** — `<leader>hs/hr/hp/hb` for hunk stage/reset/preview/blame
- [x] **bufferline.nvim** — `<S-l>/<S-h>` navigate tabs, `<leader>bd` close buffer
- [x] **toggleterm.nvim** — `<C-\>` float terminal, `<leader>th` horizontal terminal
- [x] **which-key.nvim** — keybinding popup on leader pause
- [x] **Formatter** — conform.nvim, format on save + `<leader>fm` manual
- [x] **Linter** — nvim-lint, lint on save + `<leader>l` manual

---

### Quality of Life

- [x] **autopairs** — auto-close `()`, `[]`, `{}`, `""`
- [x] **Comment.nvim** — `gcc` line comment, `gc` visual
- [x] **indent-blankline.nvim** — vertical indent guide lines
- [x] **trouble.nvim** — `<leader>xx/xw/xd` problems panel
- [x] **nvim-surround** — `ys`, `cs`, `ds` surround operations
- [x] **todo-comments.nvim** — highlights + `<leader>ft` telescope search

---

### Optional / Nice to Have

- [x] **dashboard / alpha.nvim** — start screen with quick actions
- [ ] **noice.nvim** — replaces cmdline and notifications with modern UI (`folke/noice.nvim`)
- [ ] **nvim-notify** — styled notification popups (`rcarriga/nvim-notify`)
- [x] **vim-illuminate** — highlight other uses of word under cursor
- [ ] **oil.nvim** — edit filesystem like a buffer (`stevearc/oil.nvim`)

---

## Suggested Install Order
1. ~~Fix nvim-tree plugin file~~ ✓
2. LSP stack (mason → mason-lspconfig → lspconfig) ← **user doing manually**
3. ~~Completion stack (nvim-cmp + sources + LuaSnip)~~ ← depends on LSP
4. ~~gitsigns + conform + nvim-lint~~ ✓
5. ~~bufferline + toggleterm + which-key~~ ✓
6. ~~QoL plugins (autopairs, Comment, indent-blankline, trouble)~~ ✓

## After LSP is set up

These will work better once LSP is configured:
- autocompletion (nvim-cmp)
- snippets (LuaSnip)
- trouble.nvim will show real diagnostics
- conform.nvim will pick up LSP formatters
- bufferline diagnostics will show error counts
