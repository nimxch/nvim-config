-- lua/nimxch/plugins/lsp/go.lua
-- Go language tooling: gopls (LSP) and nvim-dap-go (Delve debugger).
-- Lazy.nvim merges multiple specs for the same plugin, so declaring
-- "neovim/nvim-lspconfig" here is safe — it won't conflict with other
-- language configs that also list it.

return {
  -- ── gopls — Go language server ─────────────────────────────────────────────
  -- Lazily loaded when opening any file; lspconfig attaches gopls to .go buffers
  -- based on the filetypes gopls itself advertises.
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      local lspconfig   = require("lspconfig")
      local lsp         = require("nimxch.lsp")        -- shared on_attach & capabilities
      local go_settings = require("nimxch.lsp.go")     -- gopls-specific settings

      lspconfig.gopls.setup({
        on_attach    = lsp.on_attach,
        capabilities = lsp.capabilities,
        settings     = go_settings.settings,
      })
    end,
  },

  -- ── nvim-dap-go — Delve debugger integration ───────────────────────────────
  -- Only loaded for Go files.  Delve itself is expected to be installed via
  -- Mason (mason-lspconfig / mason-nvim-dap) or manually; nvim-dap-go picks it
  -- up automatically from PATH / Mason's bin directory.
  {
    "leoluz/nvim-dap-go",
    ft           = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()

      -- Debug the nearest test function above the cursor
      vim.keymap.set("n", "<leader>dt", function()
        require("dap-go").debug_test()
      end, { desc = "DAP Go: debug nearest test" })

      -- Re-run the last test that was debugged
      vim.keymap.set("n", "<leader>dT", function()
        require("dap-go").debug_last_test()
      end, { desc = "DAP Go: re-debug last test" })
    end,
  },
}
