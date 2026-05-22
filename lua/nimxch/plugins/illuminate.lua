-- illuminate.lua - Highlight plugin
-- Highlights all occurrences of the word under cursor
-- Repository: https://github.com/RRethy/vim-illuminate

return {
    'RRethy/vim-illuminate',
    event = "BufReadPost",
    config = function()
        require('illuminate').configure({
            delay = 200,
            filetypes_denylist = {
                'NvimTree',
                'TelescopePrompt',
                'alpha',
            },
        })
    end,
}
