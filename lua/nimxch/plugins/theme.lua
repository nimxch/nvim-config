-- lua/nimxch/plugins/theme.lua
-- Colorscheme: tokyonight (storm variant), applied via vim.cmd.colorscheme
-- at the end of setup() so it takes effect immediately on load.
--
-- Notable non-default options:
--   transparent = true  → background left unset, so the terminal's own
--                         background shows through (relies on the terminal
--                         emulator being configured for transparency/theming;
--                         tokyonight itself does not draw a background).
--   comments/keywords italic = false → default tokyonight italicizes these;
--                         disabled here purely as a font/style preference.
--   sidebars/floats = "dark" → gives nvim-tree, telescope, and floating
--                         windows (LSP hover, toggleterm, etc.) a slightly
--                         darker panel background than the main editor area.

return {

    -- TokyoNight theme
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
            })

            -- Aply the tokyonight color theme
            vim.cmd.colorscheme("tokyonight")
        end
    },

}
