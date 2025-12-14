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
vim.opt.expandtab = true    -- Use spaces instead of tabs
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

vim.cmd [[
  set shell=/opt/homebrew/bin/fish
]]

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

local plugin_collection = {
  "ai.copilot",

  "colorschemes",

  "dev.general",
  "dev.cmp",
  "dev.lsp",
  "dev.treesitter",
  "dev.latex",
  "dev.lean",

  "ui.general",
  "ui.buffers",
  "ui.lualine",
  "ui.statuscol",
  "ui.telescope",
  "ui.tree",
}

local configs = {}

for _, plugin_type in ipairs(plugin_collection) do
  local config = require("plugins." .. plugin_type)
  for _, plugin in ipairs(config) do
    configs[#configs + 1] = plugin
  end
end


require("lazy").setup(configs, {})

require("textwidth").setup()
require("rooter").setup()
require("autocmd").setup()
require("colorschemes").setup()
require("keymaps").setup()


require("neovide").setup()

-- vim: ts=2 sts=2 sw=2 et
