local colorscheme = "dawnfox"

-- local function dbg(t)
--     print(vim.inspect(t))
-- end

local function merge_into(a, b)
    for k, v in pairs(b) do
        a[k] = v
    end
end

local key = vim.keymap.set
local highlight = vim.api.nvim_set_hl

merge_into(vim.g, {
    mapleader = ' ',
    maplocalleader = ' '
})

merge_into(vim.opt, {
    winborder = "bold",
    termguicolors = true,

    number = true,
    wrap = false,
    mouse = 'a',
    showmode = false,
    clipboard = 'unnamedplus',

    undofile = true,
    swapfile = false,
    autochdir = false,

    ignorecase = true,
    smartcase = true,

    list = true,

    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    numberwidth = 3,
    cmdheight = 0,

    hlsearch = true,
    incsearch = true,

    encoding = "UTF-8",
})

local configurations = {}

local function pack(path, config_fn)
    local full_path = "https://github.com/" .. path
    if config_fn ~= nil then
        table.insert(configurations, config_fn)
    end
    return full_path
end

local function setup_packs()
    for _, config_fn in ipairs(configurations) do
        config_fn()
    end
end

vim.pack.add {
    pack("rose-pine/neovim"),

    pack("EdenEast/nightfox.nvim", function()
        require('nightfox').setup({
            options = {
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    types = "italic,bold",
                }
            }
        })
    end),

    pack("numToStr/Comment.nvim", function()
        require("Comment").setup()
    end),

    pack("folke/which-key.nvim", function()
        require("which-key").setup()
    end),

    pack('nvim-tree/nvim-web-devicons'),
    pack("folke/trouble.nvim", function()
        require("trouble").setup()
    end),

    pack("nvim-lua/plenary.nvim"),
    pack('nvim-telescope/telescope-ui-select.nvim'),
    pack("nvim-telescope/telescope.nvim", function()
        require('telescope').setup {
            defaults = require('telescope.themes').get_ivy(),
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- See `:help telescope.builtin`
    end),
    pack('mhinz/vim-startify'),
    pack('AndreM222/copilot-lualine'),
    pack('nvim-lualine/lualine.nvim', function()
        require('lualine').setup {
            options = {
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'lazy', 'NvimTree' },
                    winbar = { 'lazy', 'NvimTree' },
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { 'filename' }, --, require('lsp-progress').progress },
                lualine_x = { 'copilot', 'encoding', 'fileformat', { 'diagnostics', sources = { 'nvim_lsp' } }, 'filetype' },
                lualine_y = { 'location', 'progress' },
                lualine_z = { { 'datetime', style = '%H:%M' } },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
        }
    end),

    pack("zbirenbaum/copilot.lua", function()
        require("copilot").setup({
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<M-/>",
                    accept_word = "<M-\\>",
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
    end),

    pack('MeanderingProgrammer/render-markdown.nvim'),

    pack('akinsho/toggleterm.nvim', function()
        require("toggleterm").setup {
            version = "*",
            config = true,
            opts = {
                direction = "horizontal"
            },
        }
    end),

    pack('nvim-tree/nvim-tree.lua', function()
        require('nvim-tree').setup {
            view = {
                adaptive_size = false,
                width = 25,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = {
                        git = false,
                    },
                },
            },
            -- filters = {
            --     dotfiles = true, -- don't show dotfiles
            -- },
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },
        }
    end),

    pack('romgrk/barbar.nvim', function()
        vim.g.barbar_auto_setup = false

        highlight(0, 'BufferCurrent', { bold = true, underline = true })

        require('barbar').setup {
            auto_hide = 0,
            insert_at_end = true,
            icons = {
                button = '',
                pinned = { button = '★', filename = true },
            },
            highlight_visible = true,
        }
    end),

    pack('luukvbaal/statuscol.nvim', function()
        local builtin = require 'statuscol.builtin'
        require('statuscol').setup {
            setopt = true,
            ft_ignore = { 'NvimTree', 'lazy', 'startup' },
            segments = {
                { text = { '%C' }, click = 'v:lua.ScFa' },
                { text = { '%s' }, click = 'v:lua.ScSa' },
                {
                    text = { '', builtin.lnumfunc, "┃ " }, --' █ ' }, --builtin.lnumfunc,  }, -- ·" },
                    condition = { true, builtin.not_empty },
                    click = 'v:lua.ScLa',
                },
            },
        }
    end),

    pack('lewis6991/gitsigns.nvim', function()
        require('gitsigns').setup()
    end),

    pack("nvim-treesitter/nvim-treesitter", function()
        local langs = {
            tex = "latex",
            lua = "lua",
            python = "python",
            json = "json",
        }

        local install_names = {}
        local filetypes = {}
        for ft, name in pairs(langs) do
            table.insert(install_names, name)
            table.insert(filetypes, ft)
        end

        require("nvim-treesitter").install(install_names)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function()
                vim.treesitter.start()
                -- set foldmethods and open all folds by default
                vim.cmd [[
                    setlocal foldmethod=expr
                    setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
                    normal! zR
                ]]
            end,
        })
    end),

    pack('lervag/vimtex', function()
        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_compiler_method = "latexmk"
        -- vim.g.vimtex_quickfix_method = "pplatex"
        vim.g.vimtex_quickfix_ignore_filters = { 'Underfull', 'Overfull' } -- 'Font shape', 'multiple', 'referenced', 'cnf',
        --   'Size', 'Citation', 'reference', 'Reference' }
        -- { 'Underfull', 'Overfull', 'Token not allowed', 'Size', 'Draft', 'Citation', 'reference', 'Reference', 'Font shape',
        --   'recommended' }
        -- vim.g.vimtex_view_method = "general"
        vim.g.Tex_IgnoreLevel = 8
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = 'latexmk-build',
            continuous = 1,
            options = {
                '-shell-escape',
                '-bibtex',
                '-pdf',
                '-file-line-error',
                '-synctex=1',
                '-interaction=nonstopmode',
            },
        }
        vim.g.vimtex_view_method = 'skim'

        vim.g.vimtex_view_skim_sync = 1
        vim.g.vimtex_view_skim_activate = 1
        vim.g.vimtex_view_skim_reading_bar = 0

        -- vim.g.vimtex_view_general_viewer = 'okular'
        -- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
    end),

    pack('L3MON4D3/LuaSnip', function()
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        -- require('luasnip.loaders.from_snipmate').lazy_load()
        require('luasnip.loaders.from_lua').load({paths = "/Users/subwave/.config/nvim/snippets"})
    end),

    pack('saghen/blink.cmp', function()
        require('blink.cmp').setup {
            fuzzy = {
                implementation = "lua" -- please dont make me compile rust
            },
            sources = {
                --- omni contains vimtex completions
                default = { 'lsp', 'snippets', 'omni', 'buffer', 'path' },
            },
            snippets = { preset = 'luasnip' },
            signature = { enabled = true },
            completion = {
                keyword = { range = 'full' },
                accept = { auto_brackets = { enabled = false }, },

                list = { selection = { preselect = false, auto_insert = true } },
                menu = {
                    auto_show = true,
                    draw = {
                        columns = {
                            { "kind_icon", gap = 1 },
                            { "label",     "label_description", gap = 1 },
                            { "kind" },
                        },
                    }
                },
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = true },
            },
            keymap = {
                preset = "none",
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
            }
        }
    end),

    pack("neovim/nvim-lspconfig", function()
        local servers = {
            lua_ls = {},
            ltex_plus = { filetypes = { 'tex', 'bib', 'text' } },
            ty = {},
            ruff = {},
            gdscript = {},
        }

        local blink = require("blink.cmp")

        for name, config in pairs(servers) do
            config = config or {}
            config.capabilities = blink.get_lsp_capabilities(config.capabilities or {})
            vim.lsp.config(name, config)
            vim.lsp.enable(name)
        end
    end),

    pack('j-hui/fidget.nvim', function()
        require('fidget').setup()
    end),
}

setup_packs()

local telescope_builtin = require 'telescope.builtin'

key("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
key("v", ";", "gc", { desc = "visual mode comment", remap = true })
key("n", ";", "gccj", { desc = "normal mode comment", remap = true })
key("n", "s", "za", { desc = "toggle fold" })
key("n", "S", "zR", { desc = "open all folds" })
key("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "remove highlights" })
key("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
key("n", "<leader>w", "<C-w>", { desc = "Window" })
key("n", "<leader>s", ":w<CR>", { desc = "Save" })
key("n", "<leader>if", ":e ~/.config/nvim/init.lua<CR>", { desc = "edit config" })
key("n", "<leader>d", "<cmd>NvimTreeToggle<CR>", { desc = "Nvim-tree toggle" })
--- telescope
key("n", "<leader>/", telescope_builtin.live_grep, { desc = "live grep" })
-- key("n", "<leader>fc", telescope_builtin.current_buffer_fuzzy_find, { desc = "fuzzy search in current file" })
key("n", "<leader>f", telescope_builtin.find_files, { desc = "find files" })
key("n", "<F6>", telescope_builtin.diagnostics, { desc = "search diagnostics" })
key({ "n", "t" }, "<F7>", "<cmd>ToggleTerm<CR>", { desc = "toggle terminal" })
key("n", "<F8>", telescope_builtin.resume, { desc = "telescope resume" })
--- barbar
key("n", "<leader>>", "<Cmd>BufferMoveNext<CR>", { desc = 'buffer move next' })
key("n", "<leader><", "<Cmd>BufferMovePrevious<CR>", { desc = 'buffer move previous' })
key("n", "<leader>q", "<Cmd>BufferClose<CR>", { desc = 'close buffer' })
key("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = 'pin buffer' })
for i = 1, 9 do
    key("n", "<leader>" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", { desc = 'go to buffer ' .. i })
end
--- vimtex
key("n", "<leader>tc", "<cmd>:VimtexCompile<CR>", { desc = 'vimtex compile' })
key("n", "<leader>tv", "<cmd>:VimtexView<CR>", { desc = 'vimtex view' })
--- lsp
key("n", "<leader>h", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = "Toggle hints" })
key('n', 'gd', telescope_builtin.lsp_definitions, { desc = 'goto definition' })
key('n', 'gr', telescope_builtin.lsp_references, { desc = 'goto references' })
key('n', 'gI', telescope_builtin.lsp_implementations, { desc = 'goto implementation' })
key('n', '<F2>', vim.lsp.buf.rename, { desc = 'rename' })
key('n', '<F3>', vim.lsp.buf.format, { desc = 'format document' })
key('n', '<F4>', vim.lsp.buf.code_action, { desc = 'code action' })
key('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
key('n', 'gD', vim.lsp.buf.declaration, { desc = 'goto declaration' })
---  trouble
key("n", "<F1>", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix (Trouble)" })

--- Some handcrafted functionality

Tools = {
    fix_float_appearance = function()
        highlight(0, 'FloatBorder', { link = 'Normal' })
        highlight(0, 'NormalFloat', { link = 'Normal' })
        highlight(0, 'BlinkCmpKind', { link = 'Normal' })
        highlight(0, 'BlinkCmpMenuBorder', { link = 'Normal' })
        highlight(0, 'BlinkCmpMenu', { link = 'Normal' })
        highlight(0, 'BlinkCmpDocBorder', { link = 'Normal' })
        highlight(0, 'BlinkCmpDoc', { link = 'Normal' })
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
            opts = opts or {}
            opts.max_width = 80
            opts.max_height = 20
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end
    end,

    rooter = function()
        local project_rooter_config = {
            patterns = { '.git', 'CMakeLists.txt', 'Makefile', 'package.json', 'Cargo.toml', 'pyproject.toml', 'go.mod', 'main.tex', '.root' },
            level_limit = 10, -- how many levels to go up
        }

        local function ProjectRooter()
            local config = project_rooter_config
            local patterns = config.patterns

            local current = vim.fn.expand('%:p:h')
            local level = 0

            local found = nil

            while found == nil and level <= config.level_limit do
                if vim.fn.isdirectory(current) == 1 then
                    for _, pattern in ipairs(patterns) do
                        if vim.fn.glob(current .. '/' .. pattern) ~= '' then
                            -- Found a project root, set the working directory
                            found = current
                            break
                        end
                    end
                end

                if found ~= nil then
                    break
                end

                current = vim.fn.fnamemodify(current, ':h')
                level = level + 1
            end

            if found == nil then
                -- No project root found, notify the user
                vim.notify('No project root found in ' .. vim.fn.expand('%:p:h'), vim.log.levels.WARN)
                return
            end

            vim.ui.input({
                prompt = 'Root found. Confirm: ',
                default = found,
                completion = 'dir',
            }, function(input)
                if input ~= nil and vim.fn.isdirectory(input) == 1 then
                    vim.cmd.cd(input)
                end
            end)
        end


        key("n", "<leader>pp", ProjectRooter, { desc = "Project rooter" })
    end,

    format = function()
        key("n", "'f", "ms{gq}'s", { desc = 'Format paragraph' })
        key("v", "'f", "gq", { desc = 'Format paragraph' })

        vim.api.nvim_create_autocmd({ 'BufEnter' }, {
            pattern = { '*.md', '*.tex', },
            callback = function()
                vim.cmd [[setlocal textwidth=100]]
            end,
        })
    end
}

Tools.rooter()
Tools.format()
vim.cmd("colorscheme " .. colorscheme)
Tools.fix_float_appearance()
