# Neovim Keybindings

Leader key: `Space`

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
| `<leader>f` | Format current buffer |
| `<leader>rn` | Rename symbol |

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

## Go Snippets

| Key | Action |
|-----|--------|
| `<leader>ee` | Insert `if err != nil { return err }` below cursor |

## Misc

| Key | Action |
|-----|--------|
| `<C-c>` (insert) | Escape to normal mode |
| `<C-f>` | Open tmux-sessionizer in new tmux window |
| `<leader><leader>` | Re-source current file |
| `Q` | Disabled (prevents accidental Ex mode) |
