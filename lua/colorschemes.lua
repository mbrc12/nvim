-- local night_scheme = "gruvbox-material"
local night_scheme = "jellybeans-muted"
-- local night_scheme = "monokai-pro"
-- local night_scheme = "vague"
-- local night_scheme = "nordic"
local day_scheme = "dayfox"

function PostColorscheme()
	local highlight = vim.api.nvim_set_hl
	highlight(0, 'FloatBorder', { link = 'Normal' })
	highlight(0, 'NormalFloat', { link = 'Normal' })
end

function ToggleColorscheme()
	if vim.opt.background:get() == 'dark' then
		vim.opt.background = 'light'
		vim.cmd.colorscheme(day_scheme)
	else
		vim.opt.background = 'dark'
		vim.cmd.colorscheme(night_scheme)
	end

	PostColorscheme()
end

return {
	setup = function()
		vim.opt.background = 'dark'
		vim.cmd.colorscheme(night_scheme)
		PostColorscheme()

		local wk = require 'which-key'
		wk.add({
			{ '<F10>', ToggleColorscheme, desc = 'Toggle night/day mode' },
		})
	end
}

