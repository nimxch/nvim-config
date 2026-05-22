-- indent-blankline.nvim: Show vertical indent guide lines
-- Displays thin vertical lines at each indentation level for better code readability
return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    config = function()
        require("ibl").setup({
            -- Show vertical lines for indentation levels
            enabled = true,

            -- Highlight the current scope/indent block
            scope = {
                enabled = true,
                show_start = true,
                show_end = false,
            },

            -- Indent guide character and highlight
            indent = {
                -- Use thin vertical lines
                char = "│",
                -- Use a subtle highlight group
                highlight = "IblIndent",
            },

            -- Whitespace character settings (for empty lines)
            whitespace = {
                highlight = "IblWhitespace",
                remove_blankline_trail = true,
            },

            -- Scope lines (current indentation block)
            scope_char = "│",
        })
    end,
}
