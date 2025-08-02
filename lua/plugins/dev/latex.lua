return {
	{
		'lervag/vimtex',
		lazy = false,
		config = function()
			vim.g.tex_flavor = 'latex'
			vim.g.vimtex_compiler_method = "latexmk"
			-- vim.g.vimtex_quickfix_method = "pplatex"
			vim.g.vimtex_quickfix_ignore_filters = { 'Underfull', 'Overfull' } -- 'Font shape', 'multiple', 'referenced', 'cnf',
			--   'Size', 'Citation', 'reference', 'Reference' }
			-- { 'Underfull', 'Overfull', 'Token not allowed', 'Size', 'Draft', 'Citation', 'reference', 'Reference', 'Font shape',
			--   'recommended' }
			-- vim.g.vimtex_view_method = "general"
			vim.g.Tex_IgnoreLevel = 8
			vim.g.vimtex_compiler_latexmk = {
				aux_dir = 'latexmk-build',
				continuous = 1,
				options = {
					'-shell-escape',
					'-bibtex',
					'-pdf',
					'-file-line-error',
					'-synctex=1',
					'-interaction=nonstopmode',
				},
			}
			-- vim.g.vimtex_compiler_tectonic = {
			--   continuous = 1,
			--   -- options = { '-shell-escape', '-bibtex' },
			-- }
			vim.g.vimtex_view_method = 'skim'

			vim.g.vimtex_view_skim_sync = 1
			vim.g.vimtex_view_skim_activate = 1
			vim.g.vimtex_view_skim_reading_bar = 1

			-- vim.g.vimtex_view_general_viewer = 'okular'
			-- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
		end,
		keys = {
			{ '<leader>tc', '<cmd>:VimtexCompile<CR>', desc = 'vimtex compile' },
			{ '<leader>tv', '<cmd>:VimtexView<CR>',    desc = 'vimtex view' },
		},
	},
}
