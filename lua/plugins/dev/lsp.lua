return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'j-hui/fidget.nvim', opts = {} },
		},

		config = function()
			local default = "default"

			local servers = {
				rust_analyzer = default,

				pyright = {
					cmd = { 'uv', 'run', 'pyright-langserver', '--stdio' },
				},

				lua_ls = default,

				gdscript = default,

				gopls = {
					settings = {
						gopls = {
							buildFlags = { "-tags=wireinject" },
							hints = {
								rangeVariableTypes = true,
								parameterNames = true,
								constantValues = true,
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								functionTypeParameters = true,
							},
						}
					}
				},


				ltex_plus = {
					filetypes = { 'latex', 'tex', 'bib', 'text' },
				},
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- local border = 'single'
					local border = 'rounded'

					local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
					vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
						opts = opts or {}
						opts.border = border
						opts.max_width = 90
						opts.max_height = 20
						return orig_util_open_floating_preview(contents, syntax, opts, ...)
					end

					map('gd', require('telescope.builtin').lsp_definitions, 'goto definition')
					map('gr', require('telescope.builtin').lsp_references, 'goto references')
					map('gI', require('telescope.builtin').lsp_implementations, 'goto implementation')
					map('<leader>rr', vim.lsp.buf.rename, 'rename')
					map('<leader>?', vim.lsp.buf.code_action, 'code action')
					map('K', vim.lsp.buf.hover, 'Hover Documentation')
					map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map('<leader>th', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 })
						end, 'inlay hints')
					end
				end
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


			local function setup_server(server_name, config)
				local server = config
				-- This handles overriding only values explicitly passed
				-- by the server configuration above. Useful when disabling
				-- certain features of an LSP (for example, turning off formatting for tsserver)
				server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
				require('lspconfig')[server_name].setup(server)
			end

			for name, config in pairs(servers) do
				if config == default then
					config = {}
				end
				setup_server(name, config)
			end
		end
	},
}

