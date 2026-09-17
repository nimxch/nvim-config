-- lua/nimxch/plugins/alpha.lua
-- alpha-nvim: a startup dashboard shown in place of an empty buffer, using
-- the built-in "dashboard" theme (header + a fixed list of action buttons)
-- rather than alpha's other themes (e.g. "theta", which auto-populates
-- recent files/sessions) — buttons here are hand-picked to jump straight
-- into the workflows used most (Telescope pickers, a blank buffer, quit).
--
-- WHY event = "VimEnter": alpha must render before any real buffer/file is
-- shown, so it has to load at startup rather than lazily on first use like
-- most other plugins in this config.
--
-- Repository: https://github.com/goolord/alpha-nvim

return {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = {
        -- Renders file-icon glyphs used by the buttons/header
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header (ASCII logo/banner)
        dashboard.section.header.val = {
            "",
            "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "",
            "                    by Nimai",
            "",
        }

        -- Configure buttons for quick actions. The two-letter shortcuts
        -- ("ff", "fg") deliberately mirror the <leader>ff / <leader>fg
        -- Telescope keymaps in keymaps.lua, so the dashboard doubles as a
        -- reminder of the real keybindings rather than a separate mapping
        -- to memorize.
        dashboard.section.buttons.val = {
            dashboard.button("ff", "  Find File", ":Telescope find_files <CR>"),
            dashboard.button("fr", "  Recent Files", ":Telescope oldfiles <CR>"),
            dashboard.button("fg", "  Find Word", ":Telescope live_grep <CR>"),
            dashboard.button("nf", "  New File", ":enew <CR>"),
            dashboard.button("q", "  Quit", ":qa <CR>"),
        }

        -- Setup alpha with the dashboard theme
        alpha.setup(dashboard.opts)
    end,
}
