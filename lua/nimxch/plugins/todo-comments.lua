-- todo-comments.nvim: Highlight and search TODO, FIXME, HACK, WARN, NOTE, PERF comments
-- Integrates with Telescope for easy searching and navigation through code comments
return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("todo-comments").setup({
            -- Highlight TODO, FIXME, HACK, WARN, NOTE, PERF keywords
            keywords = {
                FIX = {
                    icon = " ",
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = {
                    icon = " ",
                    color = "info",
                },
                HACK = {
                    icon = " ",
                    color = "warning",
                },
                WARN = {
                    icon = " ",
                    color = "warning",
                    alt = { "WARNING", "XXX" },
                },
                PERF = {
                    icon = " ",
                    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
                },
                NOTE = {
                    icon = " ",
                    color = "hint",
                    alt = { "INFO" },
                },
            },
            gui_style = {
                fg = "FRONT",
                bg = "BACK",
            },
            highlight = {
                multiline = true,
                multiline_pattern = "^.",
                multiline_context = 10,
                before = "",
                keyword = "wide",
                after = "fg",
                pattern = [[.*<(KEYWORDS)\s*:]],
                comments_only = true,
                max_line_len = 400,
                exclude = {},
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                pattern = [[\b(KEYWORDS)\b]],
            },
        })

        -- ── Todo-Comments Keymaps ────────────────────────────────────────────

        -- Search TODOs using Telescope
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>",
            { noremap = true, silent = true, desc = "Search TODOs (Telescope)" })
    end,
}
