-- lua/nimxch/setup.lua
-- Plain vim.opt editor settings — no plugin dependencies, safe to load
-- before lazy.nvim finishes initializing (see load order in
-- lua/nimxch/init.lua).

-- Disable mode-based cursor shape changes (block/bar/underline). Some
-- terminals mishandle the shape-restore escape sequence on exit and leave
-- the cursor stuck as a bar afterwards; keeping one shape avoids that.
vim.opt.guicursor = ""

-- Show Relative Line Number
-- (absolute number on the current line, relative elsewhere — makes
-- `<count>j`/`<count>k` motions easy to count)
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab and Indention
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- line wrapping
vim.opt.wrap = true

-- colors
-- Required for the active colorscheme to render true 24-bit colors in a
-- terminal instead of being downsampled to the terminal's 256-color palette
vim.opt.termguicolors = true

-- scroll
-- No scroll padding — cursor can reach the very top/bottom line of the
-- window instead of stopping short
vim.opt.scrolloff = 0

-- sign column for linting and git
-- Fixed at "yes" (always one column, never "auto") so LSP diagnostics and
-- gitsigns markers appearing/disappearing don't shift the buffer text
-- left/right
vim.opt.signcolumn = "yes"

-- update time
-- Lowered from the 4000ms default — CursorHold-triggered plugins
-- (gitsigns blame, illuminate, LSP diagnostics) react after this many ms of
-- no input, so lower means faster feedback
vim.opt.updatetime = 50
