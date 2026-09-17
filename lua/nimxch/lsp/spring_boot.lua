-- lua/nimxch/lsp/spring_boot.lua
-- Config helper for the standalone Spring Boot language server ("boot-ls").
--
-- This is NOT the same thing as the Spring Boot jdtls bundle wired into
-- lua/nimxch/lsp/java.lua (which only covers .java files). boot-ls is a
-- separate LSP server that provides property-key completion, validation,
-- and hover documentation (e.g. `spring.datasource.url=`) inside
-- application.properties / application.yml files — the same feature VS
-- Code's Spring Boot extension provides for those files.
--
-- WHY A CUSTOM cmd?
-- Mason's spring-boot-tools package ships boot-ls as an *exploded* Spring
-- Boot fat jar (BOOT-INF/classes + BOOT-INF/lib/*.jar), not a single
-- runnable .jar — the same layout VS Code's own extension uses. So instead
-- of `java -jar ...`, we reconstruct the classpath by hand and launch the
-- app's Start-Class directly.
--
-- This module is consumed by lua/nimxch/plugins/lsp/spring_boot.lua, which
-- registers it as a brand-new named config via vim.lsp.config() — boot-ls
-- isn't one of the servers nvim-lspconfig ships defaults for, but the
-- native API lets us define one from scratch just as easily.

local M = {}

function M.get_config()
    local ls_dir = vim.fn.stdpath("data")
        .. "/mason/packages/spring-boot-tools/extension/language-server"

    -- Java supports a trailing "/*" classpath entry as a jar-directory
    -- wildcard on its own (no shell glob expansion needed here).
    local classpath = ls_dir .. "/BOOT-INF/classes:" .. ls_dir .. "/BOOT-INF/lib/*"

    return {
        cmd = {
            "java",
            "-cp", classpath,
            "org.springframework.ide.vscode.boot.app.BootLanguageServerBootApp",
        },

        -- application.properties → filetype "jproperties";
        -- application.yml/.yaml   → filetype "yaml" (Neovim's builtin ftdetect)
        filetypes = { "yaml", "jproperties" },

        -- Only start inside an actual Maven/Gradle project. Deliberately
        -- narrower than jdtls's root markers (no ".git") so this doesn't
        -- attach to unrelated YAML (CI configs, docker-compose, etc.) that
        -- happens to live in a git repo with no Java build file.
        root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(vim.fs.root(fname, { "pom.xml", "build.gradle", "mvnw", "gradlew" }))
        end,
    }
end

return M
