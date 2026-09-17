-- lua/nimxch/plugins/tree-sitter.lua
-- nvim-treesitter: provides up-to-date parser binaries that neovim's built-in
-- treesitter engine uses for highlighting, indentation, and text objects.
--
-- WHY lazy=false: parsers must be on runtimepath before any buffer opens.
-- WHY build=TSUpdate: recompiles parsers after plugin updates so they stay
--   in sync with neovim's bundled queries (mismatch = "Invalid field" errors).
--
-- NOTE: this is the "main" branch of nvim-treesitter (see lazy-lock.json),
-- the rewrite that dropped the old `require("nvim-treesitter.configs").setup
-- ({ ensure_installed = ..., highlight = { enable = true } })` API. This file
-- only ensures parsers are installed via `.install()` below — it does not
-- itself turn highlighting on. Neovim doesn't auto-enable treesitter
-- highlighting for arbitrary filetypes either; that normally needs an
-- explicit `vim.treesitter.start()` FileType autocmd, which does not
-- currently exist anywhere else in this config. If syntax highlighting for
-- these filetypes looks like it's missing treesitter-based highlighting,
-- start there.
--
-- Parsers installed here (vimdoc, lua, jsdoc, bash) are editor/tooling
-- languages this config itself is written in or documents — not related to
-- the four languages (Java, Python, TypeScript, Rust) configured for LSP.
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
