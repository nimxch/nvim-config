-- Auto-pair matching brackets, parentheses, and quotes
-- Provides smart auto-closing of (), [], {}, "", '', and ``
-- Uses TreeSitter awareness for intelligent pairing in code context
return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        require('nvim-autopairs').setup({
            check_ts = true,  -- Enable TreeSitter-aware pairing
        })
    end,
}
