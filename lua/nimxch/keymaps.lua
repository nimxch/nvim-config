-- Leader key set here AND in lazy.lua (lazy.lua takes effect for plugins,
-- this covers anything loaded before lazy initializes)
vim.g.mapleader = " "

-- ── File Explorer ────────────────────────────────────────────────────────────
-- nvim-tree toggle/focus (netrw disabled in setup.lua)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>t', ':NvimTreeFocus<CR>',  { noremap = true, silent = true })

-- ── Visual Mode Line Moving ───────────────────────────────────────────────────
-- Move selected lines up/down and re-indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ── Cursor Stability ─────────────────────────────────────────────────────────
-- Join line below without moving cursor (marks position with mz, restores with `z)
vim.keymap.set("n", "J", "mzJ`z")
-- Scroll half-page and keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Jump to next/prev search match and keep cursor centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ── Clipboard ────────────────────────────────────────────────────────────────
-- Paste over selection without overwriting clipboard register
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n",          "<leader>Y", [["+Y]])
-- Delete into void register (don't clobber clipboard)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- ── Insert Mode ──────────────────────────────────────────────────────────────
-- Ctrl+c as Esc (avoids InsertLeave autocmd differences of plain Esc)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- ── Disabled Keys ────────────────────────────────────────────────────────────
-- Q starts Ex mode accidentally — disable it
vim.keymap.set("n", "Q", "<nop>")

-- ── Tmux ─────────────────────────────────────────────────────────────────────
-- Open tmux-sessionizer in a new window (requires tmux-sessionizer in PATH)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")

-- ── LSP ──────────────────────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>f",  vim.lsp.buf.format)       -- format buffer
vim.keymap.set("n", "gd",         vim.lsp.buf.definition)   -- go to definition
vim.keymap.set("n", "K",          vim.lsp.buf.hover)        -- show docs
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)       -- rename symbol

-- ── Quickfix / Location List ─────────────────────────────────────────────────
-- Quickfix: used by LSP errors, grep results, etc. (global list)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- Location list: buffer-local diagnostics
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- ── Search & Replace ─────────────────────────────────────────────────────────
-- Populate substitute command with word under cursor, cursor left of flags to edit
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- ── Go Snippets ──────────────────────────────────────────────────────────────
-- Insert idiomatic Go error-check block below current line
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- ── Misc ─────────────────────────────────────────────────────────────────────
-- Re-source current file (useful when editing config live)
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

-- ── Telescope ────────────────────────────────────────────────────────────────
-- Wrapped in a function so telescope loads only when key is pressed,
-- not at startup (avoids errors if telescope isn't installed yet)
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end,  { desc = 'Telescope: find files' })
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end,   { desc = 'Telescope: live grep' })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end,     { desc = 'Telescope: buffers' })
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end,   { desc = 'Telescope: help tags' })
