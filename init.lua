vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true       -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.barbar_auto_setup = false
vim.opt.number = true             -- Make line numbers default
vim.opt.mouse = 'a'               -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false          -- Don't show the mode, since it's already in the status line
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.opt.breakindent = true        -- Enable break indent
vim.opt.undofile = true           -- Save undo history
vim.opt.ignorecase = true         -- Case-insensitive searching UNLESS \C or one or more capital letters i an the search term
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'        -- Keep signcolumn on by default
vim.opt.updatetime = 250          -- Decrease update time
vim.opt.timeoutlen = 300          -- Decrease mapped sequence wait time, displays which-key popup sooner
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '· ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = true    -- Show which line your cursor is on
vim.opt.numberwidth = 3
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.wildmenu = true
vim.opt.autoread = true
vim.opt.cmdheight = 0
vim.opt.hlsearch = true -- Set highlight on search, but clear on pressing <Esc> in normal mode


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    keys = {
      { ';', '<Plug>(comment_toggle_linewise_current)j', desc = 'Comment line',  noremap = false },
      { ';', '<Plug>(comment_toggle_linewise_visual)',   desc = 'Comment block', mode = 'v',     noremap = false },
    },
  },

  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end
  --

  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim'
  },

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
            accept = "<M-=>",
            accept_word = "<M-\\>",
            prev = "<M->>",
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
  },

  'mhinz/vim-startify',

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
            text = { ' ', builtin.lnumfunc, ' █ ' }, --builtin.lnumfunc, " ┃ " }, -- ·" },
            condition = { true, builtin.not_empty },
            click = 'v:lua.ScLa',
          },
        },
      }
    end,
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    opts = {
      open_mapping = "<C-e>",
      direction = "horizontal"
    },
  },
  -- Lua
  {
    "folke/zen-mode.nvim",
    opts = {
    }
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>q",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    }
  },

  {
    'j-morano/buffer_manager.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require("buffer_manager").setup {
        focus_alternate_buffer = true,
        order_buffers = "lastused",
      }
    end,
    keys = {
      { '<leader><leader>', [[:lua require("buffer_manager.ui").toggle_quick_menu()<CR>]], desc = 'Toggle buffer manager' },
    },
  },

  -- {
  --   'romgrk/barbar.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  --   lazy = false,
  --   config = function()
  --     require('barbar').setup {
  --       auto_hide = 1,
  --       insert_at_end = true,
  --       icons = {
  --         button = '',
  --       },
  --     }
  --   end,
  --
  --   keys = (function()
  --     local keys = {
  --       { '<leader>tr', '<Cmd>BufferMoveNext<CR>',     desc = 'buffer move to next' },
  --       { '<leader>tl', '<Cmd>BufferMovePrevious<CR>', desc = 'buffer move to previous' },
  --       { '<C-q>',      '<Cmd>BufferWipeout<CR>',      desc = 'close buffer' },
  --     }
  --
  --     for i = 1, 10 do
  --       table.insert(keys,
  --         { '<M-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>', 'change tabs', mode = { 't', 'n' } })
  --     end
  --
  --     return keys
  --   end)(),
  -- }, --barbar
  --
  -- {
  --   "ahmedkhalf/project.nvim",
  --   lazy = false,
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  --   config = function()
  --     require("project_nvim").setup {
  --       patterns = { ".git", "latexmkrc", "go.mod", "package.json", ".root" }
  --     }
  --     require("telescope").load_extension("projects")
  --   end,
  -- },

  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
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
    end,

    keys = {
      { '<leader>d', '<cmd>NvimTreeToggle<CR>', desc = 'Nvim-tree toggle' },
    },
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        defaults = require('telescope.themes').get_ivy(),
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
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
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = 'live grep' })
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find,
        { desc = 'fuzzy search in current file' })
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<F9>', builtin.diagnostics, { desc = 'search diagnostics' })
      vim.keymap.set('n', '<F12>', builtin.resume, { desc = 'telescope resume' })
      -- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      -- vim.keymap.set('n', '<leader>?', function()
      --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      --   builtin.current_buffer_fuzzy_find()
      -- end, { desc = 'fuzzy search' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      -- vim.keymap.set('n', '<leader>s/', function()
      --   builtin.live_grep {
      --     grep_open_files = true,
      --     prompt_title = 'Live Grep in Open Files',
      --   }
      -- end, { desc = '[S]earch [/] in Open Files' })
      --
      -- -- Shortcut for searching your Neovim configuration files
      -- vim.keymap.set('n', '<leader>sn', function()
      --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
      -- end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      -- {
      --   "folke/lazydev.nvim",
      --   ft = "lua", -- only load on lua files
      --   opts = {
      --     library = {
      --       -- See the configuration section for more details
      --       -- Load luvit types when the `vim.uv` word is found
      --       { path = "luvit-meta/library", words = { "vim%.uv" } },
      --     },
      --   },
      -- },
      { "Bilal2453/luvit-meta",    lazy = true }, -- optional `vim.uv` typings
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Make lsp popup borders rounded by replacing the function for preview
          -- and also limit the width
          -- local border = 'single'
          local border = 'rounded'

          local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
          function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = border
            opts.max_width = 90
            opts.max_height = 20
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, 'goto definition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, 'goto references')

          map('gI', require('telescope.builtin').lsp_implementations, 'goto implementation')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<F2>', vim.lsp.buf.rename, 'rename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<F4>', vim.lsp.buf.code_action, 'code action')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- -- WARN: This is not Goto Definition, this is Goto Declaration.
          -- --  For example, in C this would take you to the header.
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight',
              { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 })
            end, 'inlay hints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        csharp_ls = {},

        clangd = {},

        ltex = {
          filetypes = { 'latex', 'tex', 'bib', 'text' },
        },

        julials = {
        },

        svelte = {},

        jdtls = {},

        prettier = {},
        ts_ls = {},

        tinymist = {
          settings = {
            formatterMode = "typstyle",
            exportPdf = "onType",
            semanticTokens = "disable"
          }
        },

        ["some-sass-language-server"] = {
          filetypes = { 'scss', 'sass', 'css' },
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              hint = {
                enable = true,
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        terraformls = {},

        -- ts_ls = {}

        jsonls = {},

        omnisharp = {},

      }



      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      -- vim.list_extend(ensure_installed, {
      --   'stylua', -- Used to format Lua code
      -- })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }


      local function setup_server(server_name, config)
        local server = servers[server_name] or config or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end

      require('mason-lspconfig').setup {
        handlers = {
          setup_server
        },
      }

      -- setup_server("pylsp", { cmd = { "rye", "run", "pylsp" } })
      setup_server("basedpyright", { cmd = { "uv", "run", "basedpyright-langserver", "--stdio" } })
      setup_server("ruff", { cmd = { "uv", "run", "ruff", "server" } })
      -- setup_server("pylyzer", { cmd = { "rye", "run", "pylyzer", "--server" } })
      setup_server("rust_analyzer", {})
      setup_server("gopls", {
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
      })

      setup_server("gdscript", {})
    end,
  },

  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
        { desc = "Toggle Outline" })

      require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
        symbols = {
          icon_fetcher = function(kind, bufnr, symbol) return kind:sub(1, 1) end,
        }
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<F3>',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'format buffer',
      },
    },
    opts = {
      notify_on_error = false,
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true, gdscript = true }
      --   return {
      --     timeout_ms = 500,
      --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      --   }
      -- end,
      formatters_by_ft = {
        lua = { 'stylua' },
        gdscript = { 'gdformat' },
      },
    },
  },

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
        mapping = cmp.mapping.preset.insert {
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

  {
    'sainnhe/gruvbox-material',
    lazy = "VeryLazy",
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_enable_italic = '1'
      vim.g.gruvbox_material_enable_bold = '1'
      vim.g.gruvbox_material_dim_inactive_windows = '1'
    end
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').load()
    end
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          }
        }
      })
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine' },
    lazy = false,
    config = function()
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
    end,
  }, -- lualine
  {  -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'latex', 'go', 'rust', 'python' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  {
    'lervag/vimtex',
    lazy = false,
    config = function()
      vim.g.tex_flavor = 'latex'
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_method = "pplatex"
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
      -- vim.g.vimtex_compiler_tectonic = {
      --   continuous = 1,
      --   -- options = { '-shell-escape', '-bibtex' },
      -- }
      vim.g.vimtex_view_method = 'zathura_simple'

      -- vim.g.vimtex_view_general_viewer = 'okular'
      -- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
    end,
    keys = {
      { '<leader>tc', '<cmd>:VimtexCompile<CR>', desc = 'vimtex compile' },
      { '<leader>tv', '<cmd>:VimtexView<CR>',    desc = 'vimtex view' },
    },
  },
}, {})

--- Set some keymaps
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { desc = 'Change window' })

local telescope_builtin = require 'telescope.builtin'
local telescope_buffers = function()
  telescope_builtin.buffers {
    sort_lastused = true,
    ignore_current_buffer = true,
    show_all_buffers = true,
  }
end

local wk = require 'which-key'
wk.add({
  { '<Esc><Esc>', '<C-\\><C-n>',                    desc = 'Exit terminal mode',              mode = { 't' } },
  { '<Esc>',      '<cmd>nohlsearch<CR>',            desc = "remove highlights" },
  { '<leader>e',  vim.diagnostic.open_float,        desc = 'Show diagnostic [E]rror messages' },
  { '<C-s>',      ":w<CR>",                         desc = 'Save' },
  { '<C-s>',      "<Esc>:w<CR>",                    desc = 'Save',                            mode = 'i' },
  { "<leader>if", ":e ~/.config/nvim/init.lua<CR>", desc = "edit config" },
  -- { "<M-s>",      "<esc><C-w>p",                    desc = "goto other window",               mode = { 'n', 'i' } },
  -- { "<M-s>",      "<C-\\><C-n><C-w>p",              desc = "goto other window",               mode = { 't' } },
  -- { "<leader><leader>", telescope_buffers,                desc = "list buffers",                    mode = { 'n', 't' } },
  { "<C-q>",      ":bw!<CR>",                       desc = "close buffer",                    mode = { 'n' } },
  { "<C-q>",      "<C-\\><C-n>:bw!<CR>",            desc = "close buffer",                    mode = { 't' } },
  { "<F9>",       telescope_builtin.oldfiles,       desc = "recent files" },
  { "<F7>",       ":vs|te<CR>",                     desc = "vertical split and open terminal" },
})

-- A custom setup to limit width via comments, primarily for latex or markdown documents.
function TextWidthConfig()
  wk.add({
    { "'f", "ms{gq}'s", desc = 'Format paragraph' },
    { "'f", 'gq',       desc = 'Format paragraph', mode = 'v' }
  })

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = { '*.md' },
    callback = function()
      vim.cmd [[setlocal textwidth=120]]
    end,
  })
end

TextWidthConfig()

vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  }
})

local night_scheme = "gruvbox-material"
-- local night_scheme = "nordic"
local day_scheme = "dayfox"

function PostColorscheme()
  local highlight = vim.api.nvim_set_hl
  highlight(0, 'FloatBorder', { link = 'Normal' })
  highlight(0, 'NormalFloat', { link = 'Normal' })
end

vim.opt.background = 'dark'
vim.cmd.colorscheme(night_scheme)
PostColorscheme()

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

wk.add({
  { '<F10>', ToggleColorscheme, desc = 'Toggle night/day mode' },
})

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

----- Project rooter ----------------

local project_rooter_config = {
  patterns = { '.git', 'CMakeLists.txt', 'Makefile', 'package.json', 'Cargo.toml', 'pyproject.toml', 'go.mod', 'main.tex', '.root' },
  level_limit = 5, -- how many levels to go up
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

local wk = require 'which-key'

wk.add({
  { '<leader>pp', ProjectRooter, desc = 'Project rooter' },
})

vim.cmd([[hi BufferManagerModified cterm=italic ctermfg=Red gui=bold,italic guifg=#E7737F]])

--- SET COLORSCHEMES BEFORE THIS

------- Neovide config ----------------------
-- vim.o.guifont = "Iosevka Extended:h14"
-- vim.o.guifont = "CommitMono Nerd Font:h15"
-- vim.o.guifont = "Hurmit Nerd Font:h14"
-- vim.o.guifont = "JetBrains Mono:h11"
vim.o.guifont = "Fira Code Retina:h12"
-- vim.o.guifont = "Hasklug Nerd Font:h12"
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h12"
-- vim.o.guifont = "IosevkaTerm Nerd Font:h12"
-- vim.o.guifont = "IosevkaTerm Nerd Font:h14"
-- vim.o.guifont = "UbuntuMono Nerd Font:h15"
-- vim.o.guifont = "Adwaita Mono:h13"
-- vim.o.guifont = "Intel One Mono:h13.5"
-- vim.o.guifont = "InputMono Nerd Font:h13.5"

function NeovideFullscreen()
  if vim.g.neovide_fullscreen == true then
    vim.g.neovide_fullscreen = false
  else
    vim.g.neovide_fullscreen = true
  end
end

local animation_length = 0.02

vim.g.neovide_scroll_animation_length = animation_length
vim.g.neovide_cursor_animation_length = animation_length
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_vfx_particle_density = 20.0

wk.add({
  { "<F11>", NeovideFullscreen, desc = "Toggle fullscreen in neovide", mode = { "i", "n", "t", "v" } },
})


-- vim: ts=2 sts=2 sw=2 et
