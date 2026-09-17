-- lua/nimxch/plugins/comment.lua
-- Comment.nvim: toggles line/block comments with the correct comment syntax
-- for whatever filetype the cursor is in (//, #, --, <!-- -->, etc.).
-- Default keymaps: gcc (comment line), gc (visual mode), gbc (block comment).
--
-- setup() is called with no options — filetype-specific comment strings are
-- resolved automatically via Neovim's built-in 'commentstring', so there is
-- nothing project-specific to configure here.
return {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
        require('Comment').setup()
    end,
}
