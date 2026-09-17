-- lua/nimxch/plugins/conform.lua
-- conform.nvim: runs standalone CLI formatters (stylua, prettier, black, ...)
-- per filetype, independent of whichever LSP server is attached.
--
-- WHY NOT rely on LSP formatting (vim.lsp.buf.format) alone?
-- Not every attached server formats well (or at all) — e.g. ts_ls's own
-- formatter is weaker than prettier, and some filetypes here have no LSP
-- attached whatsoever (sh/bash). conform lets each filetype pick the actual
-- formatter tool people use for it, while still falling back to the LSP
-- formatter (lsp_fallback) for anything not listed below.
--
-- WHY a list like { "prettierd", "prettier", stop_after_first = true } for
-- JS/TS: prettierd is a long-running daemon (much faster than invoking
-- prettier fresh each save); it's tried first and prettier is the fallback
-- if prettierd isn't installed. stop_after_first prevents running both.

return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        python = { "black" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
      -- Runs conform on every write. async + lsp_fallback mean: format
      -- without blocking the UI, and if no formatter is configured for this
      -- filetype, ask the attached LSP server to format instead.
      format_on_save = {
        timeout_ms = 3000,
        async = true,
        lsp_fallback = true,
      },
    })

    -- Keymap for manual formatting
    -- <leader>fm to format the current buffer
    vim.keymap.set("n", "<leader>fm", function()
      conform.format({
        timeout_ms = 3000,
        async = true,
        lsp_fallback = true,
      })
    end, { noremap = true, silent = true, desc = "Format buffer" })
  end,
}
