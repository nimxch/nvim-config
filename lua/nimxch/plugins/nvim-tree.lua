-- lua/nimxch/plugins/nvim-tree.lua
-- nvim-tree: sidebar file explorer (tree view, create/rename/delete files,
-- git status icons). Toggled with <leader>e / <leader>t (see keymaps.lua).
--
-- WHY nvim-tree instead of netrw — Neovim's builtin netrw explorer is
-- disabled at the top of init.lua (`vim.g.loaded_netrw/_netrwPlugin = 1`,
-- set before any plugin loads so netrw never auto-starts on `:e <dir>`)
-- specifically so nvim-tree can own file-explorer duties instead: it gives
-- git status icons, devicons, and a persistent sidebar netrw doesn't.
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

            actions = {
                open_file = {
                    -- Keep the tree open after opening a file (default nvim-tree
                    -- behavior would close it once the last real window remains)
                    quit_on_open = false,
                    -- Prompt which window to open the file in when multiple
                    -- windows are visible, instead of guessing
                    window_picker = { enable = true },
                },
            },

            filters = {
                -- Show dotfiles (.env, .gitignore, etc.) — nvim-tree hides
                -- them by default
                dotfiles = false,
            },
        })
    end,
}
