-- lua/nimxch/plugins/git-blame.lua
-- git-blame.nvim: shows the blame info (author, date, commit summary) for
-- the current line as virtual text at the end of the line, updated as the
-- cursor moves.
--
-- WHY event = "VeryLazy": defers loading until after startup so it never
-- delays opening the first buffer; it's a passive, always-on display rather
-- than something triggered by a keymap, so there's no `keys` table gating it.

return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true,
        -- Blame line format: summary • date • author • short SHA
        message_template = " <summary> • <date> • <author> • <<sha>>",
        date_format = "%m-%d-%Y %H:%M:%S",
        -- Column virtual text starts at; 1 keeps it flush after the code
        -- rather than aligned to a fixed screen column.
        virtual_text_column = 1,
    },
}

