-- lua/nimxch/plugins/theme.lua
-- Colorscheme: Catppuccin Mocha (stock/"pure" — solid background, no
-- transparency, no color_overrides to the base palette), applied via
-- vim.cmd.colorscheme at the end of setup() so it takes effect immediately.
--
-- WHY priority = 1000: lazy.nvim loads plugins in priority order at startup;
-- the colorscheme must be applied before other UI plugins (lualine,
-- bufferline, nvim-tree, ...) define highlight groups that assume it's
-- already active, otherwise they'd briefly render with Neovim's built-in
-- defaults before catppuccin overwrites them.
--
-- WHY name = "catppuccin": the repo is "catppuccin/nvim", which would
-- otherwise install under a directory literally called "nvim" — the plugin
-- author's own README recommends this override so lazy.nvim addresses it
-- (and its cache dir) by a sane, unambiguous name.
--
-- WHY custom_highlights instead of an "accent" setting: catppuccin/nvim has
-- no single global accent switch — individual highlight groups are wired to
-- specific palette colors internally. `custom_highlights` is the documented
-- escape hatch for retargeting a handful of them to Flamingo (a soft pink —
-- "petal" tone in the palette) without touching the base Mauve-accented
-- theme everywhere else.

return {

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- catppuccin's darkest, most saturated flavor
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false, -- "pure" catppuccin: solid bg, no terminal bleed-through

                -- Only toggled on for plugins actually present in this config;
                -- everything else keeps catppuccin's own defaults.
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = { enabled = true },
                    which_key = true,
                    indent_blankline = { enabled = true },
                    dap = true,
                    dap_ui = true,
                },

                -- Retint just the "accent" surfaces to Flamingo (soft petal
                -- pink) instead of catppuccin's default Mauve accent.
                custom_highlights = function(colors)
                    return {
                        Cursor = { fg = colors.base, bg = colors.flamingo },
                        Visual = { fg = colors.base, bg = colors.flamingo },
                        Search = { fg = colors.base, bg = colors.flamingo },
                        IncSearch = { fg = colors.base, bg = colors.flamingo },
                        IblScope = { fg = colors.flamingo }, -- current indent-block guide (see indent-blankline.lua)
                        TelescopeSelection = { fg = colors.flamingo, bg = colors.surface0 },
                        TelescopeBorder = { fg = colors.flamingo },
                        WhichKeyBorder = { fg = colors.flamingo },
                    }
                end,
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },

}
