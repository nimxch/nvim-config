-- lua/nimxch/plugins/lsp/java.lua
-- Lazy.nvim plugin spec for Java language support via nvim-jdtls.
--
-- WHY nvim-jdtls instead of lspconfig?
-- Eclipse JDT Language Server (jdtls) requires:
--   1. A full JVM command with OSGi-specific flags (not a simple executable).
--   2. An OS-specific configuration directory (config_linux / config_mac / config_win).
--   3. A per-project workspace directory to keep build artefacts isolated.
--
-- lspconfig cannot express requirement 3: it starts one server instance and
-- reuses it for every buffer of the same filetype.  nvim-jdtls provides
-- jdtls.start_or_attach() which starts a fresh server per project root *or*
-- reattaches the existing server instance when the root matches, giving each
-- Maven / Gradle project its own isolated jdtls process and workspace.
--
-- INSTALLATION: the following Mason packages must be installed manually:
--   :MasonInstall jdtls java-debug-adapter java-test
--
-- The config in lua/nimxch/lsp/java.lua will silently omit DAP / test bundles
-- if those packages are absent, so LSP still works without them.

return {
    "mfussenegger/nvim-jdtls",

    -- Load the plugin only when a Java file is opened.  Lazy.nvim handles
    -- the ft trigger by watching BufReadPre; nvim-jdtls itself is not loaded
    -- until the first Java buffer is actually entered.
    ft = "java",

    config = function()
        -- ── FileType autocmd ────────────────────────────────────────────────
        -- jdtls.start_or_attach() must be called every time a Java buffer
        -- becomes active — not just once at plugin load time — because:
        --
        --   a) The user may open files from different projects in one session.
        --      Each project root requires its own jdtls server instance.
        --
        --   b) When Neovim restores a Java buffer from a session, the LSP
        --      client might not yet be attached; the autocmd re-runs the
        --      attach logic and either reuses an existing server or starts one.
        --
        -- get_config() is called inside the callback (not at plugin load time)
        -- so that root_dir, workspace, and launcher paths are evaluated for
        -- the actual buffer being opened.
        vim.api.nvim_create_autocmd("FileType", {
            pattern  = "java",
            callback = function()
                -- Build the full jdtls config for the current project root,
                -- then start a new server or reattach an existing one.
                require("jdtls").start_or_attach(
                    require("nimxch.lsp.java").get_config()
                )
            end,
        })
    end,
}
