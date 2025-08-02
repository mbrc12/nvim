return {
	setup = function()
		-- Highlight when yanking (copying) text
		--  Try it with `yap` in normal mode
		--  See `:help vim.highlight.on_yank()`
		vim.api.nvim_create_autocmd('TextYankPost', {
			desc = 'Highlight when yanking (copying) text',
			group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
			callback = function()
				vim.highlight.on_yank()
			end,
		})

		vim.api.nvim_create_autocmd({ 'BufEnter', 'TermOpen' }, {
			-- pattern = { 'term://*' },
			pattern = { '*' },
			desc = 'Enter insert in terminal immediately',
			group = vim.api.nvim_create_augroup('personal-terminal', { clear = true }),
			callback = function()
				if vim.opt.buftype:get() == 'terminal' then
					vim.cmd.startinsert()
				end
			end,
		})
	end
}
