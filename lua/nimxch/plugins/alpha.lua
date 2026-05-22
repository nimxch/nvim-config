-- alpha.lua - Dashboard plugin
-- Displays a startup dashboard with quick action buttons
-- Repository: https://github.com/goolord/alpha-nvim

return {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = {
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

        -- Configure buttons for quick actions
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
