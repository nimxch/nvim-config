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
| mason.nvim | LSP/tool installer (`:Mason`) |
| mason-lspconfig.nvim | Auto-installs pyright + gopls |
| nvim-lspconfig | LSP client (Python + Go) |
| nvim-jdtls | Java/Spring Boot LSP (jdtls) |
| nvim-dap | Debug Adapter Protocol engine |
| nvim-dap-ui | Debug UI panels |
| nvim-dap-virtual-text | Inline variable values |
| nvim-dap-python | Python debugger (debugpy) |
| nvim-dap-go | Go debugger (delve) |
| nvim-web-devicons | Icons |
| plenary.nvim | Utility lib |

---

## TODO

### Critical

- [x] **nvim-tree plugin file** — created `plugins/nvim-tree.lua`
- [x] **LSP** — mason + lspconfig configured for Python + Go + Java (Spring Boot)
  - `williamboman/mason.nvim` ✓
  - `williamboman/mason-lspconfig.nvim` ✓ (auto-installs pyright + gopls)
  - `neovim/nvim-lspconfig` ✓
  - `mfussenegger/nvim-jdtls` ✓ (Java — separate plugin for jdtls)
- [x] **DAP** — debug adapter configured for Python, Go, Java
  - `mfussenegger/nvim-dap` ✓
  - `rcarriga/nvim-dap-ui` ✓
  - `nvim-dap-python`, `nvim-dap-go` ✓
  - Java DAP via `java-debug-adapter` bundles ✓
- [ ] **Autocompletion** — nvim-cmp not yet configured
  - `hrsh7th/nvim-cmp` — completion engine
  - `hrsh7th/cmp-nvim-lsp` — LSP source
  - `hrsh7th/cmp-buffer`, `hrsh7th/cmp-path`
- [ ] **Snippets**
  - `L3MON4D3/LuaSnip` + `saadparwaiz1/cmp_luasnip`
  - `rafamadriz/friendly-snippets`

---

### High Priority (VSCode feel) — All done ✓

- [x] gitsigns, bufferline, toggleterm, which-key, conform, nvim-lint

---

### Quality of Life — All done ✓

- [x] autopairs, Comment.nvim, indent-blankline, trouble, nvim-surround, todo-comments

---

### Optional / Nice to Have

- [x] alpha.nvim, vim-illuminate
- [ ] **noice.nvim** — modern UI for cmdline/notifications (`folke/noice.nvim`)
- [ ] **nvim-notify** — styled notification popups (`rcarriga/nvim-notify`)
- [ ] **oil.nvim** — edit filesystem like a buffer (`stevearc/oil.nvim`)

---

## Mason: servers to install manually

Run these once after first launch:

```
:MasonInstall jdtls java-debug-adapter java-test debugpy delve
```

pyright and gopls install automatically via mason-lspconfig.

---

## After autocompletion (nvim-cmp) is set up

- Extend `lsp/init.lua` `M.capabilities` with `cmp_nvim_lsp.default_capabilities()`
- trouble.nvim will show real diagnostics
- bufferline error counts will appear
- conform.nvim will pick up LSP formatters

---

## LSP folder structure

```
lua/nimxch/plugins/lsp/   ← lazy.nvim plugin specs
    mason.lua              ← mason + mason-lspconfig
    python.lua             ← pyright lspconfig + nvim-dap-python
    go.lua                 ← gopls lspconfig + nvim-dap-go
    java.lua               ← nvim-jdtls (Spring Boot)
    dap.lua                ← nvim-dap + dap-ui + virtual-text + keymaps

lua/nimxch/lsp/            ← server config modules
    init.lua               ← shared on_attach, capabilities, diagnostics
    python.lua             ← pyright settings
    go.lua                 ← gopls settings
    java.lua               ← jdtls config builder (M.get_config())
```
