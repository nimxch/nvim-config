-- lua/nimxch/lsp/python.lua
-- Server options table for pyright (Python LSP).
-- This file only returns a plain options table — no require calls, no setup.
-- It is consumed by lua/nimxch/plugins/lsp/python.lua which passes
-- the settings field into lspconfig.pyright.setup().

return {
    settings = {
        python = {
            analysis = {
                -- "basic" catches common type errors without being too strict
                typeCheckingMode = "basic",
                -- Automatically add source root and workspace paths to search
                autoSearchPaths = true,
                -- Infer types from library source when stubs are unavailable
                useLibraryCodeForTypes = true,
            },
        },
    },
}
