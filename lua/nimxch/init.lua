-- lua/nimxch/init.lua
-- Load order matters here:
--   1. lazy   — bootstraps the plugin manager and sets mapleader/
--               maplocalleader *before* any plugin spec loads, since some
--               plugins read the leader at setup time.
--   2. setup  — plain vim.opt editor settings; no plugin dependency, so it
--               can safely run before plugins finish initializing.
--   3. keymaps — buffer/global keymaps. A few (Telescope, nvim-tree) call
--               require() lazily inside a function wrapper, so they don't
--               need their target plugin loaded yet — only invoked on
--               keypress.
require("nimxch.lazy")
require("nimxch.setup")
require("nimxch.keymaps")
