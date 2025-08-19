return {
	{
		"wtfox/jellybeans.nvim",
		lazy = false,
		priority = 1000,
		opts = {}, -- Optional
	},

	{
		'sainnhe/gruvbox-material',
		lazy = "VeryLazy",
		config = function()
			vim.g.gruvbox_material_background = 'hard'
			vim.g.gruvbox_material_enable_italic = '1'
			vim.g.gruvbox_material_enable_bold = '1'
			vim.g.gruvbox_material_dim_inactive_windows = '1'
		end
	},

	{
		'loctvl842/monokai-pro.nvim'
	},

	{
		"vague2k/vague.nvim",
	},

	{
		'AlexvZyl/nordic.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('nordic').load()
		end
	},

	{
		"EdenEast/nightfox.nvim",
		config = function()
			require('nightfox').setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
					}
				}
			})
		end
	},
}
