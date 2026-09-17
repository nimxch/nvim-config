-- lua/nimxch/plugins/indent-blankline.lua
-- indent-blankline.nvim (ibl v3): draws vertical guide lines at each
-- indentation level, and separately highlights the guide(s) belonging to
-- whichever indent block ("scope") the cursor is currently inside.
--
-- `indent` vs `scope`: `indent` draws a line for every indentation level in
-- the buffer at all times; `scope` re-highlights just the lines bounding the
-- cursor's current block (e.g. the if/function body it's inside) so that
-- block stands out from the rest. They're independent — `scope.char` only
-- needs to differ from `indent.char` if you want the current-scope lines to
-- look different from the rest; here both use the same glyph and rely on
-- distinct highlight groups (IblIndent vs ibl's default scope highlight).
--
-- WHY main = "ibl": the plugin's Lua module is named `ibl`, not the repo
-- name (`indent-blankline.nvim`) — lazy.nvim needs this to find it, and to
-- know which module `opts`/`config` apply to if they were used instead.
--
-- NOTE: `ibl` v3 validates its config strictly against a fixed schema, so
-- unknown top-level keys (e.g. the old v2 `scope_char` option, now
-- `scope.char`) raise a hard validation error at setup instead of being
-- ignored — this config had a leftover flat `scope_char` key that broke
-- setup() until it was moved under `scope.char`, so keep schema keys nested
-- correctly rather than adding flat, plugin-authored option names.
return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    config = function()
        require("ibl").setup({
            enabled = true,

            -- Highlight the current scope/indent block
            scope = {
                enabled = true,
                show_start = true, -- underline the line that opens the block
                show_end = false,  -- don't also underline the closing line
                char = "│",
            },

            -- Indent guide character and highlight
            indent = {
                char = "│",
                highlight = "IblIndent",
            },

            -- Whitespace character settings (for empty lines)
            whitespace = {
                highlight = "IblWhitespace",
                remove_blankline_trail = true,
            },
        })
    end,
}
