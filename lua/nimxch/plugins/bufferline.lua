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
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "("..count..")"
                end,

                -- Appearance
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
