-- lua/nimxch/plugins/trouble.lua
-- trouble.nvim: VSCode-style problems panel — lists LSP diagnostics in a
-- dedicated, navigable window instead of only inline virtual text/signs.
--
-- auto_open/auto_close = false: the panel only appears via the explicit
-- keymaps below, never automatically on new diagnostics — avoids the panel
-- popping open unprompted while editing.
-- follow = true: panel selection follows the cursor as you move through the
-- buffer, so it stays in sync without manual re-triggering.
return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
        require("trouble").setup({
            -- Use default configuration with minimal customization
            auto_open = false,
            auto_close = false,
            auto_preview = true,
            auto_refresh = true,
            focus = false,
            restore = true,
            follow = true,
            indent_guides = true,
            max_items = 200,
            multiline = true,
            pinned = false,
            severity = nil,
        })

        -- ── Trouble Keymaps ─────────────────────────────────────────────────

        -- Toggle trouble window
        vim.keymap.set("n", "<leader>xx", "<cmd>Trouble toggle<CR>",
            { noremap = true, silent = true, desc = "Trouble: toggle" })

        -- Show workspace diagnostics
        vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics toggle<CR>",
            { noremap = true, silent = true, desc = "Trouble: workspace diagnostics" })

        -- Show document diagnostics
        vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics toggle<CR>",
            { noremap = true, silent = true, desc = "Trouble: document diagnostics" })
    end,
}
