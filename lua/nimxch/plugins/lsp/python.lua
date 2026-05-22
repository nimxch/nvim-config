-- lua/nimxch/plugins/lsp/python.lua
-- Lazy.nvim plugin specs for Python language support:
--   1. nvim-lspconfig  — wires pyright into Neovim's LSP client
--   2. nvim-dap-python — registers debugpy as a DAP adapter and adds
--                        test-method / test-class debug keymaps
--
-- NOTE: nvim-lspconfig is declared once per language file.  Lazy.nvim merges
-- all specs that share the same plugin name, so there is no conflict with other
-- language files that also declare "neovim/nvim-lspconfig".

return {

  -- ── Pyright LSP ─────────────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    -- NOTE: nvim-lspconfig is declared multiple times (once per language).
    -- Lazy.nvim merges specs for the same plugin — this is intentional.
    event = "BufReadPre",
    config = function()
      local lspconfig = require("lspconfig")
      local lsp       = require("nimxch.lsp")  -- on_attach + capabilities

      lspconfig.pyright.setup({
        on_attach    = lsp.on_attach,
        capabilities = lsp.capabilities,
        -- Pull in the analysis settings from the server-options table
        settings     = require("nimxch.lsp.python").settings,
      })
    end,
  },

  -- ── debugpy DAP adapter ─────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-dap-python",
    ft           = "python", -- load only when a Python buffer is opened
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- Mason installs debugpy under stdpath("data")/mason/packages/debugpy/
      require("dap-python").setup(
        vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      )

      -- Run the test method under the cursor in a DAP session
      vim.keymap.set("n", "<leader>dt", function()
        require("dap-python").test_method()
      end, { desc = "DAP: Python test method" })

      -- Run the entire test class under the cursor in a DAP session
      vim.keymap.set("n", "<leader>dT", function()
        require("dap-python").test_class()
      end, { desc = "DAP: Python test class" })
    end,
  },

}
