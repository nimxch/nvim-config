-- nvim-lint - code linter integration
-- Provides automatic and manual linting for multiple filetypes

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Configure linters per filetype
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
