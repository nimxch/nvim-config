-- lua/nimxch/plugins/completion.lua
-- blink.cmp: the insert-mode completion engine — the popup menu, fuzzy
-- matching, and snippet expansion that attaching an LSP server alone
-- doesn't provide. Before this file, LSP navigation/hover/diagnostics/
-- formatting all worked, but there was no autocomplete popup while typing.
--
-- WHY blink.cmp over nvim-cmp: a Rust-accelerated fuzzy matcher (stays fast
-- even against large completion lists — Java/TypeScript stdlib symbols in
-- particular), a built-in snippet engine (no separate LuaSnip wiring), and
-- far less setup than nvim-cmp's per-source-plugin model.
--
-- WHY this matters beyond just this file: its LSP capabilities
-- (require("blink.cmp").get_lsp_capabilities()) are merged into
-- lsp/init.lua's shared M.capabilities, which every per-language LSP config
-- (java, python, typescript, rust, spring_boot) already builds its
-- vim.lsp.config() call from — so installing/configuring it here is enough
-- to light up completion for all four languages without touching each
-- language file individually.
return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- Prebuilt binaries are published per version tag, so pinning to a
    -- major version avoids needing a Rust toolchain to build the fuzzy
    -- matcher locally.
    version = "1.*",
    event = "InsertEnter",
    config = function()
        require("blink.cmp").setup({
            -- <C-y> accept, <C-n>/<C-p> (or <Up>/<Down>) navigate, <C-e> cancel
            keymap = { preset = "default" },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = { auto_show = true },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = {
                -- Use the prebuilt Rust matcher when available; warn and
                -- fall back to the pure-Lua implementation instead of
                -- hard-failing on platforms with no prebuilt binary.
                implementation = "prefer_rust_with_warning",
            },
        })
    end,
}
