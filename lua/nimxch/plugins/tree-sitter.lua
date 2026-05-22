-- nvim-treesitter: provides up-to-date parser binaries that neovim's built-in
-- treesitter engine uses for highlighting, indentation, and text objects.
--
-- WHY lazy=false: parsers must be on runtimepath before any buffer opens.
-- WHY build=TSUpdate: recompiles parsers after plugin updates so they stay
--   in sync with neovim's bundled queries (mismatch = "Invalid field" errors).
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- vim.schedule defers installation until after startup so it doesn't
        -- block neovim from opening. Parsers install silently in the background.
        -- Add language names here as needed. Run :TSUpdate to update them.
        vim.schedule(function()
            require("nvim-treesitter.install").install({
                "vimdoc",
                "lua",
                "jsdoc",
                "bash",
            })
        end)
    end,
}
