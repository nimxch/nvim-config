return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            -- Default size for terminal windows (for non-float direction)
            size = 15,

            -- Default direction: "float" for floating terminal (can be "horizontal", "vertical", "tab")
            direction = "float",

            -- Floating window configuration
            float_opts = {
                -- Use rounded borders instead of sharp ones
                border = "rounded",
                -- Window height (0-1 = percentage, >1 = absolute)
                height = 30,
                -- Window width (0-1 = percentage, >1 = absolute)
                width = 120,
                -- Window row position (0.5 = center)
                row = 0.35,
                -- Window column position (0.5 = center)
                col = 0.5,
                -- Highlight group for the floating window
                highlights = {
                    border = "Normal",
                    background = "Normal",
                }
            },

            -- Disable the default keymaps (we'll set custom ones below)
            open_mapping = false,
            -- Enable insert mode when terminal opens
            insert_mappings = true,
            terminal_mappings = true,

            -- Show terminal name in tab/status
            persist_size = true,
            -- Auto-close terminal when it exits
            auto_scroll = true,
            -- Close terminal with :q instead of deleting
            close_on_exit = true,
        })

        -- ── Terminal Keymaps ─────────────────────────────────────────────────

        -- Toggle floating terminal (Ctrl+Backslash)
        vim.keymap.set('n', '<C-\\>', '<cmd>ToggleTerm direction=float<CR>',
            { noremap = true, silent = true, desc = 'Toggle floating terminal' })

        -- Open horizontal terminal at bottom (leader+th)
        vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal size=15<CR>',
            { noremap = true, silent = true, desc = 'Toggle horizontal terminal' })

        -- Exit terminal mode with Escape (go to normal mode)
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>',
            { noremap = true, silent = true, desc = 'Exit terminal mode' })

        -- Also allow Ctrl+Backslash to toggle from within terminal
        vim.keymap.set('t', '<C-\\>', '<cmd>ToggleTerm<CR>',
            { noremap = true, silent = true, desc = 'Toggle terminal from terminal mode' })
    end,
}
