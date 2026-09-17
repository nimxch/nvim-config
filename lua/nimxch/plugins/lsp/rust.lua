-- lua/nimxch/plugins/lsp/rust.lua
-- Lazy.nvim plugin spec for Rust language support via rust-analyzer,
-- installed through Mason.
--
-- NOTE: nvim-lspconfig is declared once per language file.  Lazy.nvim merges
-- all specs that share the same plugin name, so there is no conflict with
-- other language files that also declare "neovim/nvim-lspconfig".

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      local lsp = require("nimxch.lsp")  -- on_attach + capabilities

      -- nvim-lspconfig >= 0.11: `lspconfig.<server>.setup()` is deprecated in
      -- favor of the native vim.lsp.config()/vim.lsp.enable() API. The plugin
      -- still ships the default filetypes/root_dir for rust_analyzer; we only
      -- override on_attach/capabilities/settings here.
      vim.lsp.config("rust_analyzer", {
        on_attach    = lsp.on_attach,
        capabilities = lsp.capabilities,
        settings     = require("nimxch.lsp.rust").settings,
      })
      vim.lsp.enable("rust_analyzer")
    end,
  },
}
