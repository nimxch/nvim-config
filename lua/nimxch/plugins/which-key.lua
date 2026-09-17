-- lua/nimxch/plugins/which-key.lua
-- which-key.nvim: after pressing <leader> (or any prefix key) and pausing,
-- pops up a menu of the keys that can follow, labeled with their `desc`.
-- This file both configures the popup and is where those `desc` labels for
-- keymaps defined elsewhere (keymaps.lua, LSP on_attach, other plugin
-- specs) get registered as group headings via wk.add() below — it doesn't
-- define the underlying mappings itself, only documents/groups them.
--
-- WHY event = "VeryLazy": which-key only needs to exist by the time the
-- user pauses on a prefix key, which is always after startup — deferring it
-- keeps it off the critical startup path.
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        -- Setup which-key with default configuration
        wk.setup({
            -- Show help popup after 1 second of inactivity on leader key
            delay = 1000,
            -- Use icons from nvim-web-devicons if available
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
        })

        -- Register leader key groups with descriptive labels
        -- These organize keybindings under the leader key into logical groups
        wk.add({
            -- Telescope keybindings: <leader>f* (Find operations)
            { "<leader>f", group = "Find (Telescope)" },

            -- Git hunks keybindings: <leader>h* (Git operations via gitsigns)
            { "<leader>h", group = "Git Hunks" },

            -- Explorer keybindings: <leader>e* (File tree navigation)
            { "<leader>e", group = "Explorer" },

            -- Terminal/Tree keybindings: <leader>t* (Tree focus)
            { "<leader>t", group = "Terminal/Tree" },

            -- Clipboard operations (individual keys without group)
            { "<leader>p", desc = "Paste over selection (clipboard safe)" },
            { "<leader>y", desc = "Yank to system clipboard" },
            { "<leader>Y", desc = "Yank line to system clipboard" },
            { "<leader>d", desc = "Delete to void register" },

            -- Quickfix and location list navigation
            { "<leader>k", desc = "Location list: next" },
            { "<leader>j", desc = "Location list: prev" },

            -- LSP operations
            { "<leader>rn", desc = "LSP: Rename symbol" },

            -- Search and replace
            { "<leader>s", desc = "Search and replace word under cursor" },

            -- Go snippets
            { "<leader>ee", desc = "Insert Go error check block" },

            -- Config reload
            { "<leader><leader>", desc = "Re-source current config file" },
        })
    end,
}
