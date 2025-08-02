return {
	{
		'j-morano/buffer_manager.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require("buffer_manager").setup {
				focus_alternate_buffer = true,
				order_buffers = "lastused",
			}

			vim.cmd([[hi BufferManagerModified cterm=italic ctermfg=Red gui=bold,italic guifg=#E7737F]])
		end,
		keys = {
			{ '<leader><leader>', [[:lua require("buffer_manager.ui").toggle_quick_menu()<CR>]], 
				desc = 'Toggle buffer manager' },
		},
	},
}
