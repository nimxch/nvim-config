-- Git signs: show diff markers in the sign column and git operations
return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup({
            -- Show signs for added, modified, and removed lines
            signs = {
                add = { text = "▎", hl = "GitSignsAdd" },
                change = { text = "▎", hl = "GitSignsChange" },
                delete = { text = "▎", hl = "GitSignsDelete" },
                topdelete = { text = "▔", hl = "GitSignsDelete" },
                changedelete = { text = "▎", hl = "GitSignsChange" },
                untracked = { text = "╲", hl = "GitSignsUntracked" },
            },
            -- Configure sign column behavior
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                follow_files = true,
            },
            -- Auto attach to new buffers
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
