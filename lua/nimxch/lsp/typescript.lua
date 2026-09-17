-- lua/nimxch/lsp/typescript.lua
-- Server options table for ts_ls (typescript-language-server).
-- This file only returns a plain options table — no require calls, no setup.
-- It is consumed by lua/nimxch/plugins/lsp/typescript.lua which passes
-- the settings field into vim.lsp.config("ts_ls", ...).

return {
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
            },
        },
    },
}
