-- lua/nimxch/lsp/rust.lua
-- Server options table for rust-analyzer.
-- This file only returns a plain options table — no require calls, no setup.
-- It is consumed by lua/nimxch/plugins/lsp/rust.lua which passes
-- the settings field into vim.lsp.config("rust_analyzer", ...).

return {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                -- Analyze all feature combinations, not just the default set
                allFeatures = true,
            },
            checkOnSave = {
                -- Run clippy instead of `cargo check` for richer lints
                command = "clippy",
            },
        },
    },
}
