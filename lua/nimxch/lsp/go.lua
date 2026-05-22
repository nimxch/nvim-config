-- lua/nimxch/lsp/go.lua
-- gopls server settings.
-- This module returns a plain table consumed by the plugin spec at
-- lua/nimxch/plugins/lsp/go.lua — it contains no setup logic of its own.

return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true, -- warn on unused function parameters
        shadow = true,       -- warn on variable shadowing
      },
      staticcheck = true, -- run staticcheck analysers inside gopls
      gofumpt = true,     -- enforce gofumpt formatting (stricter than gofmt)
    },
  },
}
