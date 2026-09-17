-- lua/nimxch/plugins/telescope.lua
-- Telescope: fuzzy-finder UI for files, live grep, buffers, help tags, etc.
-- Telescope itself runs on its built-in defaults (see config() below, which
-- only wires up the fzf-native sorter — nothing else is customized).
-- It's loaded lazily on first use: <leader>ff/fg/fb/fh in keymaps.lua each
-- `require('telescope.builtin')` directly, so Telescope (and this spec) only
-- loads the first time one of those keys is pressed; lazy.nvim intercepts
-- that require() regardless of the config() function below, so adding one
-- doesn't change when the plugin loads.
--
-- plenary.nvim is a hard dependency — Telescope's core (async jobs, path
-- utilities) is built on it.
--
-- telescope-fzf-native.nvim replaces Telescope's default Lua fuzzy sorter
-- with a compiled (`make`) native one — much faster on large file/grep
-- results. It has to be turned on explicitly via load_extension('fzf'),
-- which is what config() below does; without that call it would install but
-- never actually get used.
return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        require('telescope').load_extension('fzf')
    end,
}
