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

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
		},
		build = "make tiktoken",        -- Only on MacOS or Linux
		opts = {
			-- debug = true,                 -- Enable debugging
			-- See Configuration section for rest
		},
		keys = {
			{ "<leader>cg", "<cmd>CopilotChatToggle<CR>",  desc = "Toggle Copilot Chat" },
			{ "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Explain current code with copilot", mode = "v" },
		},
		-- See Commands section for default commands if you want to lazy load on them
	}
}
