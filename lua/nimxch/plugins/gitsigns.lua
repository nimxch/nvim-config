-- lua/nimxch/plugins/gitsigns.lua
-- gitsigns.nvim: per-line hunk signs in the sign column (add/change/delete)
-- plus hunk-level git operations (stage/reset/preview) and on-demand
-- current-line blame — the interactive counterpart to git-blame.nvim's
-- always-on blame text (see plugins/git-blame.lua).
--
-- WHY current_line_blame = false here but toggleable via <leader>hb:
-- git-blame.nvim already shows blame text at all times, so gitsigns' own
-- blame is left off by default to avoid showing it twice; the keymap lets
-- it be flipped on if git-blame.nvim is ever disabled.
return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "▎", hl = "GitSignsAdd" },
                change = { text = "▎", hl = "GitSignsChange" },
                delete = { text = "▎", hl = "GitSignsDelete" },
                topdelete = { text = "▔", hl = "GitSignsDelete" },
                changedelete = { text = "▎", hl = "GitSignsChange" },
                -- Files not yet added to git get their own sign/color so
                -- they're visually distinct from tracked-and-changed lines
                untracked = { text = "╲", hl = "GitSignsUntracked" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            -- Re-resolve the signed file across git renames/moves
            watch_gitdir = {
                follow_files = true,
            },
            -- Show signs even for files git doesn't track yet (new files)
            attach_to_untracked = true,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 100,
            },
        })

        -- Keymaps for gitsigns operations
        local gitsigns = require("gitsigns")
        local opts = { noremap = true, silent = true }

        -- Stage current hunk
        vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, opts)
        -- Reset current hunk
        vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, opts)
        -- Preview hunk diff
        vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)
        -- Toggle current line blame (inline)
        vim.keymap.set("n", "<leader>hb", gitsigns.toggle_current_line_blame, opts)
    end,
}
