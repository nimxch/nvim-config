return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            -- Show git status icons on files/folders
            git = { enable = true },

            view = {
                width = 35,
                side = "left",
            },

            renderer = {
                -- Show indent markers for nested files
                indent_markers = { enable = true },
                icons = {
                    show = {
                        file        = true,
                        folder      = true,
                        folder_arrow = true,
                        git         = true,
                    },
                },
            },

            -- Close nvim-tree if it's the last open window
            actions = {
                open_file = {
                    quit_on_open = false,
                    window_picker = { enable = true },
                },
            },

            filters = {
                -- Show dotfiles (.env, .gitignore, etc.)
                dotfiles = false,
            },
        })
    end,
}
