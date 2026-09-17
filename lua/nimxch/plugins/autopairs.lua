-- lua/nimxch/plugins/autopairs.lua
-- nvim-autopairs: auto-closes (), [], {}, "", '', and `` as they're typed.
--
-- WHY check_ts = true: without TreeSitter awareness, autopairs closes
-- brackets/quotes purely by character count, which misfires inside strings,
-- comments, and Rust lifetimes/generics (e.g. a lone ' opening a char
-- literal). check_ts asks the parser what node the cursor is in first, so
-- pairing only kicks in where it's actually syntactically valid.
--
-- WHY event = 'InsertEnter': the plugin has nothing to do until the user
-- starts typing, so loading it lazily on first insert avoids adding to
-- startup time.
return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        require('nvim-autopairs').setup({
            check_ts = true,  -- Enable TreeSitter-aware pairing
        })
    end,
}
