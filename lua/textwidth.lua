-- A custom setup to limit width via comments, primarily for latex or markdown documents.
return {
	setup = function()
		local wk = require 'which-key'
		wk.add({
			{ "'f", "ms{gq}'s", desc = 'Format paragraph' },
			{ "'f", 'gq',       desc = 'Format paragraph', mode = 'v' }
		})

		vim.api.nvim_create_autocmd({ 'BufEnter' }, {
			pattern = { '*.md' },
			callback = function()
				vim.cmd [[setlocal textwidth=120]]
			end,
		})
	end
}

