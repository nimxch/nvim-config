-- lua/nimxch/plugins/todo-comments.lua
-- todo-comments.nvim: highlights TODO/FIXME/HACK/WARN/NOTE/PERF comments
-- in-buffer via a virtual-text sign, using treesitter to only match inside
-- actual comments (not strings or prose).
--
-- <leader>ft runs :TodoTelescope, the picker todo-comments registers to
-- search all such markers project-wide. That command is provided by
-- telescope.nvim (see plugins/telescope.lua), so it's declared here as a
-- dependency alongside plenary.nvim to guarantee it's loaded before the
-- keymap below is used.
return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("todo-comments").setup({})

        -- Search TODOs using Telescope
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>",
            { noremap = true, silent = true, desc = "Search TODOs (Telescope)" })
    end,
}
