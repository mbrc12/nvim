return {
    {
        'numToStr/Comment.nvim',
        opts = {},
        keys = {
            { ';', '<Plug>(comment_toggle_linewise_current)j', desc = 'Comment line',  noremap = false },
            { ';', '<Plug>(comment_toggle_linewise_visual)',   desc = 'Comment block', mode = 'v',     noremap = false },
        },
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<F1>",
                "<cmd>Trouble quickfix toggle<cr>",
                desc = "Quickfix (Trouble)",
            },
            -- {
            --     "<F2>",
            --     "<cmd>Trouble quickfix toggle<cr>",
            --     desc = "Quickfix (Trouble)",
            -- },
        }
    },

    {
        "hedyhli/outline.nvim",
        config = function()
            -- Example mapping to toggle outline
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
                { desc = "Toggle Outline" })

            require("outline").setup {
                -- Your setup opts here (leave empty to use defaults)
                symbols = {
                    icon_fetcher = function(kind, bufnr, symbol) return kind:sub(1, 1) end,
                }
            }
        end,
    },
    -- lazy.nvim
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        opts = {
            foldKeymaps = {
                setup = false,
            },
        }, -- needed even when using default config

        -- recommended: disable vim's auto-folding
        init = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
    }, 

    { -- Autoformat
        'stevearc/conform.nvim',
        lazy = false,
        keys = {
            {
                '<F3>',
                function()
                    require('conform').format { async = true, lsp_fallback = true }
                end,
                mode = '',
                desc = 'format buffer',
            },
        },
        opts = {
            notify_on_error = false,
            -- format_on_save = function(bufnr)
            --   -- Disable "format_on_save lsp_fallback" for languages that don't
            --   -- have a well standardized coding style. You can add additional
            --   -- languages here or re-enable it for the disabled ones.
            --   local disable_filetypes = { c = true, cpp = true, gdscript = true }
            --   return {
            --     timeout_ms = 500,
            --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            --   }
            -- end,
            formatters_by_ft = {
                -- typescript = { 'prettier' },
                lua = { 'stylua' },
                gdscript = { 'gdformat' },
            },
        },
    },

}
