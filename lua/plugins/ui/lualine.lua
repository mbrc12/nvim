return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine' },
		lazy = false,
		config = function()
			require('lualine').setup {
				options = {
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = { 'lazy', 'NvimTree' },
						winbar = { 'lazy', 'NvimTree' },
					},
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff' },
					lualine_c = { 'filename' }, --, require('lsp-progress').progress },
					lualine_x = { 'copilot', 'encoding', 'fileformat', { 'diagnostics', sources = { 'nvim_lsp' } }, 'filetype' },
					lualine_y = { 'location', 'progress' },
					lualine_z = { { 'datetime', style = '%H:%M' } },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {},
				},
			}
		end,
	}, -- lualine
}
