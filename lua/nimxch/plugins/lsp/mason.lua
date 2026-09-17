-- lua/nimxch/plugins/lsp/mason.lua
-- Mason: manages the installation of external LSP servers, DAPs, linters,
-- and formatters.  mason-lspconfig bridges Mason with nvim-lspconfig so that
-- servers installed via Mason are automatically available to lspconfig.
--
-- NOTE: jdtls (Java) is intentionally excluded here — it is managed by the
-- nvim-jdtls plugin which has its own lifecycle handling. Its companion
-- packages (java-debug-adapter, java-test, spring-boot-tools), debugpy
-- (Python DAP, see plugins/lsp/python.lua), and the formatter/linter CLIs
-- conform.nvim/nvim-lint shell out to (black, prettierd, eslint_d, pylint,
-- shellcheck) are likewise not auto-installed here — see README.md's
-- "Install LSP servers & tools" section for the full manual install command.

return {
  -- Mason: the package manager for LSP servers and other external tools
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- keep the registry up to date after install
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
    end,
  },

  -- mason-lspconfig: wires Mason-installed servers into nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- Servers to install automatically (jdtls handled separately by nvim-jdtls)
        ensure_installed = {
          "pyright",       -- Python
          "ts_ls",         -- TypeScript / JavaScript
          "rust_analyzer", -- Rust
        },
      })
    end,
  },
}
