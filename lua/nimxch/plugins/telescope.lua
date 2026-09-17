-- lua/nimxch/plugins/telescope.lua
-- Telescope: fuzzy-finder UI for files, live grep, buffers, help tags, etc.
-- No config()/setup() call here — Telescope runs on its built-in defaults.
-- It's loaded lazily on first use instead: <leader>ff/fg/fb/fh in
-- keymaps.lua each `require('telescope.builtin')` directly, so Telescope
-- (and this spec) only loads the first time one of those keys is pressed.
--
-- plenary.nvim is a hard dependency — Telescope's core (async jobs, path
-- utilities) is built on it.
--
-- NOTE: telescope-fzf-native.nvim is listed as a dependency (for a faster
-- native fuzzy-matching sorter) but is never activated with
-- `telescope.load_extension('fzf')` anywhere in this config, so today it
-- installs but has no effect — Telescope still uses its default Lua sorter.
return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
}
