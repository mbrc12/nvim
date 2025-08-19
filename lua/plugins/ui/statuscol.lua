return {
	{
		'luukvbaal/statuscol.nvim',
		lazy = false,
		config = function()
			local builtin = require 'statuscol.builtin'
			require('statuscol').setup {
				setopt = true,

				ft_ignore = { 'NvimTree', 'lazy', 'startup' },

				segments = {
					{ text = { '%C' }, click = 'v:lua.ScFa' },
					{ text = { '%s' }, click = 'v:lua.ScSa' },
					{
						text = { '', builtin.lnumfunc, " ┃ " }, --' █ ' }, --builtin.lnumfunc,  }, -- ·" },
						condition = { true, builtin.not_empty },
						click = 'v:lua.ScLa',
					},
				},
			}
		end,
	},
}
