-- lua/nimxch/plugins/lsp/spring_boot.lua
-- Registers the standalone Spring Boot language server ("boot-ls") for
-- application.properties / application.yml files inside Maven/Gradle
-- projects.
--
-- This is separate from the Spring Boot bundle loaded into jdtls in
-- lua/nimxch/lsp/java.lua, which only covers .java files — see
-- lua/nimxch/lsp/spring_boot.lua for why two separate mechanisms are needed.
--
-- INSTALLATION: :MasonInstall spring-boot-tools
--
-- NOTE: nvim-lspconfig is declared once per language file.  Lazy.nvim merges
-- all specs that share the same plugin name, so there is no conflict with
-- other language files that also declare "neovim/nvim-lspconfig". boot-ls
-- itself isn't a server nvim-lspconfig ships defaults for; vim.lsp.config()
-- lets us define a brand-new named config directly.

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      local lsp = require("nimxch.lsp")  -- on_attach + capabilities
      local cfg = require("nimxch.lsp.spring_boot").get_config()

      cfg.on_attach    = lsp.on_attach
      cfg.capabilities = lsp.capabilities

      vim.lsp.config("spring_boot_ls", cfg)
      vim.lsp.enable("spring_boot_ls")
    end,
  },
}
