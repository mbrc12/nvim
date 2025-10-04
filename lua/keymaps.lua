return {
	setup = function()
		local wk = require 'which-key'

		local telescope_builtin = require 'telescope.builtin'

		wk.add({
			{ '<Esc><Esc>', '<C-\\><C-n>',                    desc = 'Exit terminal mode',              mode = { 't' } },

            { 's',       'za',                            desc = 'toggle fold', mode = { 'n' } },

            { '<leader>h', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = 'Toggle [H]ints' },

			{ '<Esc>',      '<cmd>nohlsearch<CR>',            desc = "remove highlights" },

			{ '<leader>e',  vim.diagnostic.open_float,        desc = 'Show diagnostic [E]rror messages' },

			{ '<leader>w',  '<C-w>',                          desc = 'Window', mode = {'n'}},
			-- { '<leader>q',      "<C-\\><C-n><C-w>w",							desc = "Next window", mode = {'t', 'n'}},

			-- { '<D-q>',      ':bd<CR>',				desc='Buffer delete', mode = {'n' }},

			{ '<leader>s',      ":w<CR>",                         desc = 'Save' },
			-- { '<leader>s',      "<Esc>:w<CR>",                    desc = 'Save',                            mode = 'i' },

			{ "<leader>if", ":e ~/.config/nvim/init.lua<CR>", desc = "edit config" },
			-- { "<M-s>",      "<esc><C-w>p",                    desc = "goto other window",               mode = { 'n', 'i' } },
			-- { "<M-s>",      "<C-\\><C-n><C-w>p",              desc = "goto other window",               mode = { 't' } },
			-- { "<leader><leader>", telescope_buffers,                desc = "list buffers",                    mode = { 'n', 't' } },
			--
			{ "<F6>",      ":bw!<CR>",                       desc = "close buffer",                    mode = { 'n' } },
			{ "<F6>",      "<C-\\><C-n>:bw!<CR>",            desc = "close buffer",                    mode = { 't' } },

			{ "<F9>",       telescope_builtin.oldfiles,       desc = "recent files" },
			-- { "<F7>",       ":vs|te<CR>",                     desc = "vertical split and open terminal" },
		})
	end
}
