-- init.lua
-- Top-level Neovim entrypoint. Kept to two things: disabling netrw and
-- handing off to the real config in lua/nimxch/.
--
-- WHY disable netrw here, before the require:
-- netrw autoloads itself as soon as a directory buffer or a filetype
-- autocmd fires. nvim-tree.lua (lua/nimxch/plugins/nvim-tree.lua) replaces
-- it as the file explorer, so netrw must be disabled before any plugin or
-- filetype plugin has a chance to load — hence these two lines run before
-- require("nimxch"), which is what bootstraps lazy.nvim and all plugins.
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

require("nimxch")
