-- Surround text with brackets, quotes, tags, etc.
-- Default keymaps: ys (add), cs (change), ds (delete)
-- Works with motions and text objects for flexible text wrapping
return {
    'kylechui/nvim-surround',
    event = "VeryLazy",
    config = function()
        require('nvim-surround').setup({})
    end,
}
