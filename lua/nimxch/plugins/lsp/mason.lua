-- lua/nimxch/plugins/lsp/mason.lua
-- Mason: manages the installation of external LSP servers, DAPs, linters,
-- and formatters.  mason-lspconfig bridges Mason with nvim-lspconfig so that
-- servers installed via Mason are automatically available to lspconfig.
--
-- NOTE: jdtls (Java) is intentionally excluded here — it is managed by the
-- nvim-jdtls plugin which has its own lifecycle handling.

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
          "pyright", -- Python
          "gopls",   -- Go
        },
      })
    end,
  },
}
