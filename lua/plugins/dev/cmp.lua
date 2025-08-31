return {
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
                dependencies = {},
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'micangl/cmp-vimtex',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            require('luasnip.loaders.from_snipmate').lazy_load()

            cmp.setup {
                -- experimental = {
                --   ghost_text = true
                -- },
                -- sorting = my_sorting,
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- completion = { completeopt = 'menu,menuone,noinsert' },

                formatting = {
                    expandable_indicator = true,
                    fields = { 'menu', 'abbr', 'kind' },
                    format = function(entry, item)
                        local MAX_LABEL_WIDTH = 60
                        local ELLIPSIS_CHAR = '…'

                        -- local function fixed_width(content)
                        --   local result = ''
                        --   if #content > MAX_LABEL_WIDTH then
                        --     result = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
                        --   else
                        --     result = content
                        --   end
                        --   return result
                        -- end

                        local menu_icon = {
                            nvim_lsp = 'λ ',
                            vimtex = 'ξ ',
                            luasnip = '⋗ ',
                            buffer = 'Ω ',
                            path = '🖫 ',
                        }

                        -- item.abbr = fixed_width(item.abbr)

                        item.menu = menu_icon[entry.source.name]
                        item.kind_hl_group = 'TSString'

                        if entry.source.name == 'vimtex' then
                            item.kind = 'VimTeX'
                        end

                        return item
                    end,
                },

                window = {
                    completion = {
                        -- border = 'single',
                        border = 'rounded',
                        -- winhighlight = "NormalFloat:Normal"
                        winhighlight = 'Normal:CmpNormal',
                    },

                    documentation = {
                        -- border = 'single',
                        border = 'rounded',
                        max_width = 60,
                        -- max_height = 20,
                    },
                },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                -- mapping = cmp.mapping.preset.insert {
                -- 	['<CR>'] = cmp.mapping.confirm {},
                -- 	['<Tab>'] = cmp.mapping.select_next_item(),
                -- 	['<S-Tab>'] = cmp.mapping.select_prev_item(),
                -- },
                -- See https://www.reddit.com/r/neovim/comments/10r7l63/how_to_stop_nvimcmp_from_using_my_arrow_keys/
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm {},
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                },
                sources = {
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'lazydev',                group_index = 0 },
                    { name = 'copilot' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'vimtex' },
                    { name = 'buffer' },
                },
            }
        end,
    },
}
