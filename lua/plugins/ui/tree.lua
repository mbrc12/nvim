return {
	{
		'nvim-tree/nvim-tree.lua',
		lazy = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		config = function()
			require('nvim-tree').setup {
				view = {
					adaptive_size = false,
					width = 25,
				},

				renderer = {
					group_empty = true,
					highlight_git = true,
					icons = {
						show = {
							git = false,
						},
					},
				},

				-- filters = {
				--     dotfiles = true, -- don't show dotfiles
				-- },
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			}
		end,

		keys = {
			{ '<leader>d', '<cmd>NvimTreeToggle<CR>', desc = 'Nvim-tree toggle' },
		},
	},
}
