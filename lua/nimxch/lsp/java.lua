-- lua/nimxch/lsp/java.lua
-- Configuration helper for nvim-jdtls (Eclipse JDT Language Server).
--
-- WHY NOT lspconfig?
-- jdtls has a non-standard startup model: it requires a JVM command with many
-- Eclipse-specific flags, an OS-specific configuration directory, and a
-- per-project data workspace directory.  nvim-jdtls wraps all that complexity
-- and must be started via jdtls.start_or_attach() rather than lspconfig.setup().
--
-- This module is consumed by lua/nimxch/plugins/lsp/java.lua, which calls
-- M.get_config() inside a FileType autocommand so jdtls is (re-)started
-- whenever Neovim opens a Java buffer.

local M = {}

function M.get_config()
    local jdtls = require("jdtls")
    local lsp   = require("nimxch.lsp")  -- shared on_attach + capabilities

    -- ── jdtls launcher jar ──────────────────────────────────────────────────
    -- Mason installs jdtls under stdpath("data")/mason/packages/jdtls/.
    -- The executable entry-point is an OSGi launcher jar whose filename
    -- includes a version string, so we use glob() to locate it at runtime.
    local mason_path  = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    -- ── OS-specific configuration directory ────────────────────────────────
    -- jdtls ships three platform config directories (config_linux, config_mac,
    -- config_win).  We detect the host OS and pick the right one.
    local os_config = "linux"
    if vim.fn.has("mac") == 1 then
        os_config = "mac"
    elseif vim.fn.has("win32") == 1 then
        os_config = "win"
    end

    -- ── Per-project workspace isolation ────────────────────────────────────
    -- jdtls stores compilation artefacts, index data, and project metadata in
    -- a "workspace" directory.  Re-using the same workspace for different
    -- projects causes jdtls to mix up settings and classpaths.
    --
    -- Solution: derive a workspace path from the project's root folder name
    -- so that every project gets its own isolated workspace under
    -- stdpath("data")/jdtls-workspace/<project-name>.
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace    = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

    return {
        -- ── Server command ────────────────────────────────────────────────
        -- jdtls is launched as a JVM process; the flags below are required by
        -- the Eclipse OSGi runtime that jdtls is built on top of.
        cmd = {
            "java",
            -- OSGi application identity
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            -- Enable verbose server-side logging (helps with debugging)
            "-Dlog.level=ALL",
            -- Give the JVM up to 2 GiB heap; bump this for very large codebases
            "-Xmx2g",
            -- Required by newer Java versions that restrict reflective access
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            -- The launcher jar is the OSGi bootstrap entry-point
            "-jar", launcher_jar,
            -- Platform-specific runtime configuration
            "-configuration", mason_path .. "/config_" .. os_config,
            -- Isolated per-project workspace (see note above)
            "-data", workspace,
        },

        -- ── Project root detection ────────────────────────────────────────
        -- jdtls.setup.find_root() walks upward from the current buffer's path
        -- looking for any of these marker files/directories.  The first match
        -- becomes the project root; nil means "open file as standalone".
        root_dir = jdtls.setup.find_root({
            ".git",
            "mvnw",
            "gradlew",
            "pom.xml",
            "build.gradle",
        }),

        -- ── Language server settings ──────────────────────────────────────
        settings = {
            java = {
                eclipse = {
                    -- Fetch attached sources so "go to definition" shows real code
                    downloadSources = true,
                },
                configuration = {
                    -- Prompt the user to reload when build config changes
                    updateBuildConfiguration = "interactive",
                },
                maven = {
                    -- Download Maven dependency sources into the workspace
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    -- Show "N implementations" above interface methods
                    enabled = true,
                },
                referencesCodeLens = {
                    -- Show "N references" above methods and fields
                    enabled = true,
                },
                format = {
                    -- Enable jdtls's built-in formatter (uses Eclipse code style)
                    enabled = true,
                },
            },
        },

        -- ── on_attach ────────────────────────────────────────────────────
        -- Called once when jdtls successfully attaches to a Java buffer.
        -- We first apply the shared LSP keymaps, then add Java-specific ones.
        on_attach = function(client, bufnr)
            -- Apply standard LSP keymaps (gd, gr, gi, K, <leader>rn, etc.)
            lsp.on_attach(client, bufnr)

            -- Organize imports: removes unused imports and sorts the rest
            vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, {
                buffer = bufnr,
                desc = "Java: organize imports",
            })

            -- Extract variable: wraps the expression under the cursor in a
            -- local variable declaration (refactoring)
            vim.keymap.set("n", "<leader>rv", jdtls.extract_variable, {
                buffer = bufnr,
                desc = "Java: extract variable",
            })

            -- Extract method: moves the selected code block into a new method
            -- (refactoring)
            vim.keymap.set("n", "<leader>rm", jdtls.extract_method, {
                buffer = bufnr,
                desc = "Java: extract method",
            })

            -- ── DAP integration ───────────────────────────────────────────
            -- jdtls acts as both LSP server AND debug adapter host.
            -- setup_dap() registers the JDWP adapter with nvim-dap and
            -- enables hot-code-replace so changed classes are reloaded into
            -- a running JVM without restarting the debug session.
            --
            -- NOTE: this is a no-op if the java-debug-adapter bundle was not
            -- found (see init_options.bundles below).
            jdtls.setup_dap({ hotcodereplace = "auto" })
        end,

        -- Reuse the shared capability table (extended by nvim-cmp if present)
        capabilities = lsp.capabilities,

        -- ── DAP / test extension bundles ──────────────────────────────────
        -- jdtls can host additional Eclipse plug-ins via init_options.bundles.
        -- Two Mason packages extend jdtls with debug and test capabilities:
        --
        --   java-debug-adapter  → com.microsoft.java.debug.plugin-*.jar
        --     Implements the DAP adapter inside the jdtls JVM process so
        --     nvim-dap can attach without spawning a separate adapter process.
        --
        --   java-test           → a set of jars that expose test discovery,
        --     running, and result reporting via jdtls code lenses.
        --
        -- Both packages are optional: if Mason has not installed them the
        -- glob() calls return empty strings / empty lists and we just skip them.
        init_options = {
            bundles = (function()
                local bundles = {}

                -- java-debug-adapter: single jar
                local debug_jar = vim.fn.glob(
                    vim.fn.stdpath("data")
                    .. "/mason/packages/java-debug-adapter"
                    .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
                )
                if debug_jar ~= "" then
                    table.insert(bundles, debug_jar)
                end

                -- java-test: multiple jars — pass true, true to glob() to get
                -- a Lua list rather than a newline-separated string
                local test_jars = vim.fn.glob(
                    vim.fn.stdpath("data")
                    .. "/mason/packages/java-test/extension/server/*.jar",
                    true,   -- nosuf (no suffix expansion)
                    true    -- list  (return a Lua table, not a string)
                )
                vim.list_extend(bundles, test_jars)

                return bundles
            end)(),
        },
    }
end

return M
