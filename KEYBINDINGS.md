# Neovim Keybindings

Leader key: `Space`

> This is a quick lookup cheat sheet. `README.md`'s [Keybindings](README.md#keybindings) section
> is the authoritative, fuller reference (LSP per-language extras, DAP, git, diagnostics, etc.) —
> if the two ever disagree, trust the README.

## File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle nvim-tree |
| `<leader>t` | Focus nvim-tree |

## Telescope (Fuzzy Finder)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text in project) |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Show hover docs |
| `<leader>fm` | Format current buffer (conform.nvim) |
| `<leader>rn` | Rename symbol |

`<leader>f` (no `m`) is a separate plain-LSP-format fallback for buffers with no formatter
configured — see README.md's note on this.

## Navigation

| Key | Action |
|-----|--------|
| `<C-d>` | Scroll down half-page (cursor centered) |
| `<C-u>` | Scroll up half-page (cursor centered) |
| `n` | Next search match (centered) |
| `N` | Previous search match (centered) |
| `J` (normal) | Join line below without moving cursor |

## Quickfix List
Used by LSP diagnostics, grep results, etc.

| Key | Action |
|-----|--------|
| `<C-k>` | Next quickfix item |
| `<C-j>` | Previous quickfix item |
| `<leader>k` | Next location list item |
| `<leader>j` | Previous location list item |

## Visual Mode

| Key | Action |
|-----|--------|
| `J` | Move selected lines down |
| `K` | Move selected lines up |

## Clipboard

| Key | Mode | Action |
|-----|------|--------|
| `<leader>y` | Normal / Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `<leader>p` | Visual | Paste over selection without clobbering clipboard |
| `<leader>d` | Normal / Visual | Delete to void (don't overwrite clipboard) |

## Search & Replace

| Key | Action |
|-----|--------|
| `<leader>s` | Search & replace word under cursor (edit before Enter) |

## Misc

| Key | Action |
|-----|--------|
| `<C-c>` (insert) | Escape to normal mode |
| `<C-f>` | Open tmux-sessionizer in new tmux window |
| `<leader><leader>` | Re-source current file |
| `Q` | Disabled (prevents accidental Ex mode) |
