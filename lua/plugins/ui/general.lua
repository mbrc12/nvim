return {
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end,
	},

	{                     -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VimEnter', -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require('which-key').setup()
		end,
	},

	{
		'MeanderingProgrammer/render-markdown.nvim'
	},

	'mhinz/vim-startify',

	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = true,
		opts = {
			open_mapping = "<F7>",
			direction = "horizontal"
		},
	},

	{
		"folke/zen-mode.nvim",
		opts = {
		}
	},
}
