-- lua/nimxch/plugins/illuminate.lua
-- vim-illuminate: highlights every other occurrence of the symbol under the
-- cursor in the current buffer (via LSP references when a server is
-- attached, falling back to a regex/treesitter match otherwise).
-- Repository: https://github.com/RRethy/vim-illuminate
--
-- WHY the denylist: NvimTree/TelescopePrompt/alpha are UI buffers, not code
-- — there's no "symbol under cursor" to illuminate there, and running it
-- anyway would just add pointless highlight churn while navigating those
-- panels.

return {
    'RRethy/vim-illuminate',
    event = "BufReadPost",
    config = function()
        require('illuminate').configure({
            -- Wait 200ms after cursor movement before highlighting, so
            -- rapid cursor movement doesn't trigger repeated highlight passes
            delay = 200,
            filetypes_denylist = {
                'NvimTree',
                'TelescopePrompt',
                'alpha',
            },
        })
    end,
}
