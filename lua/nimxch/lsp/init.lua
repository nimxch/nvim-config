-- lua/nimxch/lsp/init.lua
-- Shared LSP utilities used by all language server configurations.
-- on_attach and capabilities are defined here so individual language
-- configs only need to require this module rather than duplicate the setup.

local M = {}

-- on_attach: called whenever an LSP server attaches to a buffer.
-- Sets up buffer-local keymaps for common LSP actions.
M.on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Go to definition
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- Show all references
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  -- Go to implementation
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  -- Hover documentation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  -- Rename symbol
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  -- Code action
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  -- Go to type definition
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  -- Navigate to previous diagnostic
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  -- Navigate to next diagnostic
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  -- Send diagnostics to the location list
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

-- capabilities: base client capabilities, extended later by nvim-cmp.
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Configure diagnostic display globally.
vim.diagnostic.config({
  virtual_text = true,   -- show inline diagnostic messages
  signs = true,          -- show signs in the sign column
  underline = true,      -- underline the offending text
  update_in_insert = false, -- only update diagnostics on leaving insert mode
})

return M
