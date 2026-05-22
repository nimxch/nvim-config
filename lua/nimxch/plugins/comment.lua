-- Comment out lines and blocks with ease
-- Default keymaps: gcc (comment line), gc (visual mode), gbc (block comment)
-- Handles all languages intelligently with built-in comment patterns
return {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
        require('Comment').setup()
    end,
}
