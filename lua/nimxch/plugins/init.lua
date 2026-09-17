-- lua/nimxch/plugins/init.lua
-- plenary.nvim: a shared Lua utility library (async, path/job helpers, test
-- harness, etc.) that several other plugins in this config depend on at
-- runtime (e.g. telescope.nvim). It is declared here as its own top-level
-- spec — rather than only appearing inside another plugin's `dependencies`
-- table — so it installs and loads reliably regardless of which dependent
-- plugin lazy.nvim happens to resolve first.
return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    }
}
