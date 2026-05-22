-- lua/nimxch/plugins/lsp/dap.lua
-- Shared DAP (Debug Adapter Protocol) infrastructure.
-- Provides the core engine, UI panels, and virtual-text variable display used
-- by all language-specific debugger configs (Python, Go, Java).

return {
  -- ── Core DAP engine ────────────────────────────────────────────────────────
  -- nvim-dap implements the Debug Adapter Protocol client.  Language adapters
  -- (debugpy, delve, nvim-jdtls) register themselves against this plugin.
  {
    "mfussenegger/nvim-dap",
  },

  -- ── Async library required by nvim-dap-ui ──────────────────────────────────
  {
    "nvim-neotest/nvim-nio",
  },

  -- ── DAP virtual text ───────────────────────────────────────────────────────
  -- Shows current variable values as virtual text inline in the buffer while
  -- a debug session is active.
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter", -- required for node inspection
    },
  },

  -- ── DAP UI ─────────────────────────────────────────────────────────────────
  -- Floating/split panels for watches, breakpoints, call stack, scopes, REPL,
  -- and console output.  Wired to auto-open/close with the debug session.
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap    = require("dap")
      local dapui  = require("dapui")

      -- Initialise UI and virtual-text with their defaults
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- ── Auto open/close dap-ui with the debug session ──────────────────────
      -- Open all dap-ui panels as soon as the adapter signals it is ready
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- Close panels when the debuggee terminates normally …
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      -- … or exits with a non-zero code
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- ── DAP keymaps ────────────────────────────────────────────────────────
      -- Function-key row: mirrors the standard IDE debug toolbar layout
      vim.keymap.set("n", "<F5>",  dap.continue,   { desc = "DAP: start / continue" })
      vim.keymap.set("n", "<F10>", dap.step_over,  { desc = "DAP: step over" })
      vim.keymap.set("n", "<F11>", dap.step_into,  { desc = "DAP: step into" })
      vim.keymap.set("n", "<F12>", dap.step_out,   { desc = "DAP: step out" })

      -- Breakpoints
      -- Toggle a plain breakpoint on the current line
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
      -- Set a conditional breakpoint (prompts for an expression in the command line)
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: conditional breakpoint" })

      -- REPL / UI controls
      vim.keymap.set("n", "<leader>dr", dap.repl.open,  { desc = "DAP: open REPL" })
      vim.keymap.set("n", "<leader>du", dapui.toggle,   { desc = "DAP: toggle UI" })
      vim.keymap.set("n", "<leader>dl", dap.run_last,   { desc = "DAP: re-run last session" })
    end,
  },
}
