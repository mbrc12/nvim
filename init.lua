-- the first theme will be the default
local colorschemes = {
  'gruvbox-material',
  'sonokai',
  'vague',
  'srcery',
  'kanagawa-wave',
  'terafox',
  'zenwritten',
  'everforest',
  'dayfox',
  'melange',
  'gruvbox-baby',
}

vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_enable_italic = '1'
-- vim.g.gruvbox_material_enable_bold = '1'
vim.g.gruvbox_material_dim_inactive_windows = '1'

vim.g.srcery_bright_white = "#e2d4bc" -- modify the default white to be slightly less stark
vim.g.srcery_green = "#4c927e"        -- make the green more bluish
vim.g.srcery_italic = 1

vim.g.sonokai_style = "shusia"
vim.g.sonokai_enable_italic = true

vim.g.everforest_enable_italic = true
vim.g.everforest_background = "hard"

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.g.barbar_auto_setup = false

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters i an the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '· ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
-- vim.opt.scrolloff = 10

vim.opt.numberwidth = 5

vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.wildmenu = true
vim.opt.autoread = true

vim.opt.cmdheight = 0

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

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

-- [[ Configure and install plugins ]]
--
require('lazy').setup({
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
    keys = {
      { ';', '<Plug>(comment_toggle_linewise_current)j', desc = 'Comment line',  noremap = false },
      { ';', '<Plug>(comment_toggle_linewise_visual)',   desc = 'Comment block', mode = 'v',     noremap = false },
    },
  },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
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

      -- Document existing key chains
      -- require('which-key').register {
      --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      --   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      --   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      --   ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
      -- }
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
            accept = "<M-l>",
            accept_word = "<M-;>",
            prev = "<M-[>",
            next = "<M-]>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          markdown = true
        },
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
      { "<leader>g",  "<cmd>CopilotChatToggle<CR>",  desc = "Toggle Copilot Chat" },
      { "<leader>g;", "<cmd>CopilotChatExplain<CR>", desc = "Explain current code with copilot", mode = "v" },
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
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("vstask").setup {
        config_dir = ".tasks",
        cache_json_conf = false
      }
    end,
    keys = {
      {
        "<F5>",
        function()
          require("telescope").extensions.vstask.tasks()
        end,
        desc = "Launch tasks"
      }
    }
  },
  {
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    lazy = false,
    config = function()
      require('barbar').setup {
        auto_hide = 1,
        insert_at_end = true,
        icons = {
          button = '',
        },
      }
    end,

    keys = (function()
      local keys = {
        { '<M->>', '<Cmd>BufferMoveNext<CR>',     desc = 'buffer move to next' },
        { '<M-<>', '<Cmd>BufferMovePrevious<CR>', desc = 'buffer move to previous' },
        { '<C-q>', '<Cmd>BufferWipeout<CR>',      desc = 'close buffer' },
      }

      for i = 1, 10 do
        table.insert(keys, { '<M-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>', 'change tabs', mode = { 't', 'n' } })
      end

      return keys
    end)(),
  }, --barbar

  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("project_nvim").setup {
        patterns = { ".git", "latexmkrc", "go.mod", "package.json", ".root" }
      }
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>p", function() require 'telescope'.extensions.projects.projects {} end, "Open projects" }
    }
  },

  {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
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

      -- Nmap('<leader>d', ':ProjectRootExe NvimTreeToggle<CR>', {silent = true})
    end,

    keys = {
      { '<leader>d', '<cmd>NvimTreeToggle<CR>', desc = 'Nvim-tree toggle' },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

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
      -- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'search help' })
      -- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      -- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'live grep' })
      vim.keymap.set('n', '<leader>f', builtin.current_buffer_fuzzy_find, { desc = 'fuzzy search in current file' })
      vim.keymap.set('n', '<leader>s', builtin.find_files, { desc = 'find files' })
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

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          -- map('gI', require('telescope.builtin').lsp_implementations, 'goto implementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'type definition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          -- map('<leader>ss', require('telescope.builtin').lsp_document_symbols, 'document symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace symbols')

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
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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

      -- require("lspconfig.configs").lspai = {
      --   default_config = {
      --     cmd = { "lsp-ai" },
      --     filetypes = { "go" },
      --     root_dir = require("lspconfig").util.root_pattern(".git"),
      --     init_options = {
      --       memory = {
      --         file_store = {}
      --       },
      --       models = {
      --         model1 = {
      --           type = "ollama",
      --           model = "starcoder2",
      --         }
      --       },
      --       completion = {
      --         model = "model1",
      --         parameters = {
      --           fim = {
      --             start = "<fim_prefix>",
      --             middle = "<fim_suffix>",
      --             ["end"] = "<fim_middle>"
      --           },
      --           max_context = 2000,
      --           max_new_tokens = 32
      --         }
      --       }
      --     }
      --   }
      -- }
      --
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
        clangd = {},
        ltex = {
          filetypes = { 'latex', 'tex', 'bib', 'text' },
        },

        julials = {
        },

        svelte = {},

        jdtls = {},

        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine


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

        volar = {
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        },

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
      setup_server("pyright", { cmd = { "uv", "run", "basedpyright-langserver", "--stdio" } })
      setup_server("ruff_lsp", { cmd = { "uv", "run", "ruff-lsp" } })
      -- setup_server("csharp_ls", {})
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

      -- require("lspconfig").lspai.setup {}
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
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },


  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     doc_lines = 0
  --   },
  --   config = function(_, opts) require 'lsp_signature'.setup(opts) end
  -- },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        -- build = (function()
        --   -- Build Step is needed for regex support in snippets.
        --   -- This step is not supported in many windows environments.
        --   -- Remove the below condition to re-enable on windows.
        --   if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        --     return
        --   end
        --   return 'make install_jsregexp'
        -- end)(),
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

      --- https://github.com/SilasMarvin/lsp-ai/pull/17/files
      -- local function ai_top_comparator(entry1, entry2)
      --   local comp_item = entry1:get_completion_item()
      --   if comp_item ~= nil then
      --     if string.sub(comp_item.label, 1, 4) == "ai -" then
      --       return true
      --     end
      --   end
      --   comp_item = entry2:get_completion_item()
      --   if comp_item ~= nil then
      --     if string.sub(comp_item.label, 1, 4) == "ai -" then
      --       return false
      --     end
      --   end
      --   return nil
      -- end
      --
      -- local default_sorting = require('cmp.config.default')().sorting
      -- local my_sorting = vim.tbl_extend("force", {}, default_sorting)
      -- table.insert(my_sorting.comparators, 1, ai_top_comparator)
      --- ends custom comparator

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
            border = 'rounded',
            -- winhighlight = "NormalFloat:Normal"
            winhighlight = 'Normal:CmpNormal',
          },

          documentation = {
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
          -- Select the [n]ext item
          -- ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          -- ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          -- ['<CR>'] = cmp.mapping.confirm {},
          -- ['Tab'] = cmp.mapping.confirm { select = true },
          -- ['<S-Tab>'] = cmp.mapping.confirm { select = true },
          -- ['<Down>'] = cmp.mapping.select_next_item(),
          -- ['<Up>'] = cmp.mapping.select_prev_item(),

          ['<CR>'] = cmp.mapping.confirm {},
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          -- ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp_signature_help' },
          { name = 'lazydev',                group_index = 0 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'vimtex' },
          { name = 'buffer' },
        },
      }
    end,
  },

  "vague2k/vague.nvim",

  "savq/melange-nvim",

  "sainnhe/everforest",

  'Mofiqul/dracula.nvim',

  "EdenEast/nightfox.nvim",

  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
  },

  {
    "srcery-colors/srcery-vim",
    lazy = false,
    priority = 1000,
  },

  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },

  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      }
    }
  },

  {
    'sainnhe/gruvbox-material',
    lazy = "VeryLazy",
  },

  {
    'luisiacc/gruvbox-baby',
    priority = 1000,
    config = function()
      -- vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_keyword_style = 'italic'
      vim.g.gruvbox_baby_background_color = 'dark'

      -- Each highlight group must follow the structure:
      -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
      -- See also :h highlight-guifg
      -- Example:
      -- vim.g.gruvbox_baby_highlights = {Normal = {fg = "#123123", bg = "NONE", style="underline"}}

      -- Enable telescope theme
      vim.g.gruvbox_baby_telescope_theme = 1

      -- Enable transparent mode
      -- vim.g.gruvbox_baby_transparent_mode = 1
    end,
  },

  -- -- Highlight todo, notes, etc in comments
  -- { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
          lualine_x = { 'encoding', 'fileformat', { 'diagnostics', sources = { 'nvim_lsp' } }, 'filetype' },
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
      vim.g.vimtex_quickfix_ignore_filters = { 'Underfull', 'Overfull', 'Font shape', 'multiple', 'referenced', 'cnf',
        'Size' }
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
      { '<leader>tt', '<cmd>:VimtexCompile<CR>',            desc = 'vimtex compile' },
      { '<leader>tv', '<cmd>:VimtexView<CR>',               desc = 'vimtex view' },
      { '<C-c><C-c>', '<esc>:w<cr><cmd>:VimtexCompile<CR>', desc = 'vimtex compile', mode = 'i' },
      { '<C-c><C-c>', ':w<cr><cmd>:VimtexCompile<CR>',      desc = 'vimtex compile', mode = 'n' },
    },
  },
}, {})

--- Set some keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { desc = 'Change window' })

local wk = require 'which-key'
wk.add({
  { '<Esc>',      '<cmd>nohlsearch<CR>',            desc = "remove highlights" },
  -- Diagnostic keymaps
  { '[d',         vim.diagnostic.goto_prev,         desc = 'Go to previous [D]iagnostic message' },
  { ']d',         vim.diagnostic.goto_next,         desc = 'Go to next [D]iagnostic message' },
  { '<leader>q',  vim.diagnostic.open_float,        desc = 'Show diagnostic [E]rror messages' },
  { '<C-s>',      ":w<CR>",                         desc = 'Save' },
  { '<C-s>',      "<Esc>:w<CR>",                    desc = 'Save',                               mode = 'i' },
  { "<leader>11", ":e ~/.config/nvim/init.lua<CR>", desc = "edit config" }
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



local current_colorscheme_index = 1

local function set_colorscheme(index)
  local colorscheme = colorschemes[index]
  if colorscheme then
    vim.cmd.colorscheme(colorscheme)
  else
    print("Colorscheme not found!")
  end
end

set_colorscheme(current_colorscheme_index)

vim.keymap.set('n', '<leader>cs', function()
  current_colorscheme_index = current_colorscheme_index % #colorschemes + 1
  set_colorscheme(current_colorscheme_index)
  print("Switched to colorscheme: " .. colorschemes[current_colorscheme_index])
end, { desc = 'Cycle through colorschemes' })

set_colorscheme(current_colorscheme_index)

local highlight = vim.api.nvim_set_hl
highlight(0, 'FloatBorder', { link = 'Normal' })
highlight(0, 'NormalFloat', { link = 'Normal' })


------- Neovide config ----------------------
-- vim.o.guifont = "Iosevka Extended:h14"
-- vim.o.guifont = "CommitMono Nerd Font:h15"
-- vim.o.guifont = "Hurmit Nerd Font:h14"
vim.o.guifont = "JetBrains Mono:h11"
-- vim.o.guifont = "Fira Code:h12"
-- vim.o.guifont = "Hasklug Nerd Font:h16"
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h12"
-- vim.o.guifont = "IosevkaTerm Nerd Font:h12"
-- vim.o.guifont = "IosevkaTermSlab Nerd Font:h12"
-- vim.o.guifont = "UbuntuMono Nerd Font:h14.5"

function NeovideFullscreen()
  if vim.g.neovide_fullscreen == true then
    vim.g.neovide_fullscreen = false
  else
    vim.g.neovide_fullscreen = true
  end
end

vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_vfx_particle_density = 20.0

wk.add({
  { "<F11>", NeovideFullscreen, desc = "Toggle fullscreen in neovide", mode = { "i", "n", "t", "v" } },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
