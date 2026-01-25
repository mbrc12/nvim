return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = {
					auto_refresh = false,
					keymap = {
						accept = "<CR>",
						jump_prev = "[[",
						jump_next = "]]",
						refresh = "gr",
						open = "<M-CR>",
					},
				},
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<M-l>",
						accept_word = "<M-\\>",
						-- prev = "<M->>",
					},
				},
				filetypes = {
					markdown = true
				},
				server_opts_overrides = {
					settings = {
						telemetry = {
							telemetryLevel = "off"
						}
					}
				}
			})
		end,
	},
}
