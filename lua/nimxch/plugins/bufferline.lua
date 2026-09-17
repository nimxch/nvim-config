-- lua/nimxch/plugins/bufferline.lua
-- bufferline.nvim: renders a tab/buffer bar along the top of the window,
-- with LSP diagnostic counts per tab and a dedicated slot for the file
-- explorer sidebar (see `offsets` below).
--
-- WHY mode = "tabs" instead of the default "buffers": this config only
-- shows one entry per Vim *tabpage* rather than one per open buffer, so the
-- bar stays a small, stable set of workspaces instead of growing with every
-- file you've ever opened in the session.
--
-- nvim-web-devicons supplies the per-filetype icons shown next to each tab.
return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("bufferline").setup {
            options = {
                -- VSCode-style tab appearance
                mode = "tabs", -- set to "tabs" to only show tabpages instead of all the buffers
                numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,

                -- Buffer close behavior
                close_command = "bdelete! %d", -- can be a string | function, window on close
                right_mouse_command = "bdelete! %d",

                -- Diagnostics integration with LSP
                diagnostics = "nvim_lsp", -- | "coc" | "ale" | "quickfix" | false,
                diagnostics_update_in_insert = false,
                -- Default indicator shows an icon per severity; this collapses
                -- it to a plain "(N)" count to keep tabs narrow.
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "("..count..")"
                end,

                -- Reserves a labeled column the width of the nvim-tree sidebar
                -- so the bufferline doesn't render underneath/behind it.
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "left",
                        separator = true,
                    }
                },
                separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },

                -- Tab styling
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,

                -- Enforce item ordering
                enforce_regular_tabs = false,
                -- Keep the bar visible even with a single tab/buffer open,
                -- so the layout doesn't shift when a second one is created.
                always_show_bufferline = true,

                -- Hover preview
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = {'close'}
                },
            },
        }

        -- ── Buffer Navigation ────────────────────────────────────────────────
        -- Next buffer (Shift+L)
        vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>',
            { noremap = true, silent = true, desc = 'Next buffer' })

        -- Previous buffer (Shift+H)
        vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>',
            { noremap = true, silent = true, desc = 'Previous buffer' })

        -- Close current buffer (leader+bd)
        vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>',
            { noremap = true, silent = true, desc = 'Delete buffer' })
    end
}
