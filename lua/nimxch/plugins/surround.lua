-- lua/nimxch/plugins/surround.lua
-- nvim-surround: add/change/delete surrounding pairs (brackets, quotes,
-- tags) around a motion or text object.
-- Default keymaps: ys (add), cs (change), ds (delete)
-- setup({}) uses the plugin's built-in defaults as-is — no overrides needed.
return {
    'kylechui/nvim-surround',
    event = "VeryLazy",
    config = function()
        require('nvim-surround').setup({})
    end,
}
