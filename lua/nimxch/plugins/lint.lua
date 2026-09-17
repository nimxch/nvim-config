-- lua/nimxch/plugins/lint.lua
-- nvim-lint: runs external linter CLIs (eslint_d, pylint, shellcheck) and
-- publishes their output as native vim.diagnostic entries.
--
-- WHY A SEPARATE PLUGIN — lint vs format vs LSP diagnostics are three
-- distinct concerns in this config, each owned by a different tool:
--   • nvim-lint (this file)      — style/correctness *linters* per filetype,
--                                  run on save/read, e.g. eslint_d, pylint.
--   • conform.nvim (conform.lua) — code *formatters*, rewrite the buffer.
--   • LSP servers (plugins/lsp/) — diagnostics that come from the language
--                                  server itself (type errors, jdtls/pyright
--                                  problems), always-on while attached.
-- A linter and its filetype's LSP server often overlap (e.g. pyright already
-- flags some issues pylint does), but linters catch style/lint rules LSPs
-- don't enforce, so both run side by side and diagnostics merge in the
-- sign column / virtual text.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- One or more linter CLIs per filetype; nvim-lint runs all of them and
    -- merges their output. Each binary (eslint_d, pylint, shellcheck) must
    -- be installed/on PATH separately — nvim-lint only runs them, it does
    -- not install them (unlike Mason-managed LSP servers).
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "pylint" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
    }

    -- Auto-lint on BufWritePost and BufReadPost
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Keymap for manual linting
    -- <leader>l to trigger lint on current buffer
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { noremap = true, silent = true, desc = "Trigger lint" })
  end,
}
