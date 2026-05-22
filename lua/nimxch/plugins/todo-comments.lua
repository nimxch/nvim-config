-- todo-comments.nvim: Highlight and search TODO, FIXME, HACK, WARN, NOTE, PERF comments
-- Integrates with Telescope for easy searching and navigation through code comments
return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("todo-comments").setup({})

        -- Search TODOs using Telescope
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>",
            { noremap = true, silent = true, desc = "Search TODOs (Telescope)" })
    end,
}
