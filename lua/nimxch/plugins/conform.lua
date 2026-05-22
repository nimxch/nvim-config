-- conform.nvim - code formatter integration
-- Provides automatic and manual formatting for multiple filetypes

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
        go = { "gofmt", "goimports" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
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
