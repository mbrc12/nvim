return {
    -- {
    -- 	'j-morano/buffer_manager.nvim',
    -- 	lazy = false,
    -- 	dependencies = {
    -- 		'nvim-lua/plenary.nvim',
    -- 	},
    -- 	config = function()
    -- 		require("buffer_manager").setup {
    -- 			focus_alternate_buffer = true,
    -- 			order_buffers = "lastused",
    -- 		}
    --
    -- 		vim.cmd([[hi BufferManagerModified cterm=italic ctermfg=Red gui=bold,italic guifg=#E7737F]])
    -- 	end,
    -- 	keys = {
    -- 		{ '<leader><leader>', [[:lua require("buffer_manager.ui").toggle_quick_menu()<CR>]],
    -- 			desc = 'Toggle buffer manager' },
    -- 	},
    -- },

    {
        'romgrk/barbar.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        lazy = false,
        config = function()
            -- local highlight = vim.api.nvim_set_hl
            -- highlight(0, 'BufferDefaultCurrent', { link = 'QuickFixLine' })
            -- highlight(0, 'BufferCurrent', { bg = '#3a3f4b', bold = true })

            require('barbar').setup {
                auto_hide = 0,
                insert_at_end = true,
                icons = {
                    button = '',
                },
            }

        end,

        keys = (function()
            local keys = {
                { '<D->>', '<Cmd>BufferMoveNext<CR>',     desc = 'buffer move to next' },
                { '<D-<>', '<Cmd>BufferMovePrevious<CR>', desc = 'buffer move to previous' },
                { '<D-q>', '<Cmd>BufferWipeout<CR>',      desc = 'close buffer' },
            }

            for i = 1, 10 do
                table.insert(keys,
                    { '<D-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>', 'change tabs', mode = { 't', 'n' } })
            end

            return keys
        end)(),
    }, --barbar
}
