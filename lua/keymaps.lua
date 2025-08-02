return {
	setup = function()
		local wk = require 'which-key'

		local telescope_builtin = require 'telescope.builtin'

		wk.add({
			{ '<Esc><Esc>', '<C-\\><C-n>',                    desc = 'Exit terminal mode',              mode = { 't' } },

			{ '<Esc>',      '<cmd>nohlsearch<CR>',            desc = "remove highlights" },

			{ '<leader>e',  vim.diagnostic.open_float,        desc = 'Show diagnostic [E]rror messages' },

			{ '<leader>w',  '<C-w>',                          desc = 'Window', },
			{ '<D-q>',      "<C-w>w",													desc = "Next window" },

			{ '<D-s>',      ":w<CR>",                         desc = 'Save' },
			{ '<D-s>',      "<Esc>:w<CR>",                    desc = 'Save',                            mode = 'i' },

			{ "<leader>if", ":e ~/.config/nvim/init.lua<CR>", desc = "edit config" },
			-- { "<M-s>",      "<esc><C-w>p",                    desc = "goto other window",               mode = { 'n', 'i' } },
			-- { "<M-s>",      "<C-\\><C-n><C-w>p",              desc = "goto other window",               mode = { 't' } },
			-- { "<leader><leader>", telescope_buffers,                desc = "list buffers",                    mode = { 'n', 't' } },
			--
			{ "<D-w>",      ":bw!<CR>",                       desc = "close buffer",                    mode = { 'n' } },
			{ "<D-w>",      "<C-\\><C-n>:bw!<CR>",            desc = "close buffer",                    mode = { 't' } },

			{ "<F9>",       telescope_builtin.oldfiles,       desc = "recent files" },
			{ "<F7>",       ":vs|te<CR>",                     desc = "vertical split and open terminal" },
		})
	end
}
