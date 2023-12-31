-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
	    'git',
	    'clone',
	    '--filter=blob:none',
	    'https://github.com/folke/lazy.nvim.git',
	    '--branch=stable',
	    lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)


-- ===================== install plugins ===============================
require('lazy').setup({
    -- git
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',

    -- tabs
    'tpope/vim-sleuth',
    'tpope/vim-surround',

    -- sorround brackets
    'm4xshen/autoclose.nvim',

    -- writing tool
    'junegunn/goyo.vim',

    -- tmux
    "christoomey/vim-tmux-navigator",

    -- colorscheme
    {
	--'neanias/everforest-nvim',
	--'navarasu/onedark.nvim',
	'rose-pine/neovim',
	priority = 1000,
	config = function()
	  vim.cmd.colorscheme 'rose-pine'
	end,
    },

    -- bottom status bar
    'nvim-lualine/lualine.nvim',

    -- comment blocks
    { 'numToStr/Comment.nvim', opts = {} },

    -- show keybinds
    { 'folke/which-key.nvim',  opts = {} },

    'Bekaboo/deadcolumn.nvim', -- 80 textline limit

    'simrat39/symbols-outline.nvim', -- symbols outline

    { 'nvim-tree/nvim-tree.lua', 'nvim-tree/nvim-web-devicons' }, -- file tree

    -- indent tracker
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

    -- "github/copilot.vim",

    "RRethy/vim-illuminate", -- common word highlighting

    "wfxr/minimap.vim", -- minimap

    require 'plugins.lsp', -- call lsp setup
    require 'plugins.autocomplete', -- call autocompletion
    require 'plugins.telescope', -- fuzy finder
    require 'plugins.treesitter', -- tree sitter for highlighting
    require 'plugins.dap' -- debugger
})


-- ===================== Setup Plugins ==============================
require("autoclose").setup({
  seys = {
    ["("] = { escape = false, close = true, pair = "()" },
    ["["] = { escape = false, close = true, pair = "[]" },
    ["{"] = { escape = false, close = true, pair = "{}" },

    [">"] = { escape = true, close = false, pair = "<>" },
    [")"] = { escape = true, close = false, pair = "()" },
    ["]"] = { escape = true, close = false, pair = "[]" },
    ["}"] = { escape = true, close = false, pair = "{}" },

    ['"'] = { escape = true, close = true, pair = '""' },
    ["'"] = { escape = true, close = true, pair = "''" },
    ["`"] = { escape = true, close = true, pair = "``" },
    },
options = {
    disabled_filetypes = { "text" },
    disable_when_touch = true,
    touch_regex = "[%w(%[{]",
    pair_spaces = true,
    auto_indent = true,
  },
})

require("gitsigns").setup({
    -- See `:help gitsigns.txt`
    signs = {
	add = { text = '+' },
	change = { text = '~' },
	delete = { text = '_' },
	topdelete = { text = '‾' },
	changedelete = { text = '~' },
    },
})

require("lualine").setup({
    options = {
	icons_enabled = false,
        theme = 'rose-pine',
        component_separators = '',
        section_separators = '',
    }
})

require("telescope").setup {
    defaults = {
	mappings = {
	  i = {
	    ['<C-u>'] = false,
	    ['<C-d>'] = false,
	  },
	},
    },
}
require("deadcolumn").setup{}

pcall(require('telescope').load_extension, 'fzf')


vim.cmd('source ~/.config/nvim/lua/configure/goyo.vim')
require 'configure.telescope'
require 'configure.treesitter'
require 'configure.lsp'
require 'configure.autocomplete'
require 'configure.trees'
require 'configure.indent'
require 'configure.illuminate'

-- =========================== OPTIONS =====================
-- tabs
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- right column line
vim.wo.colorcolumn = "79"

-- set so universal copy and paste
vim.o.clipboard = 'unnamedplus'

-- ignores capitols on search unless \C or capitol in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true


-- highlight on yank 
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
	vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- ============================== GLOBAL KEYBINDS ============================
local opts = { noremap = true, silent = true }

-- set so in terminal mode you can use cntl hjkl keybiinde
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")
-- vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-N><C-h>", opts)
-- vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-N><C-j>", opts)
-- vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-N><C-k>", opts)
-- vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-N><C-l>", opts)

vim.keymap.set("t", "<C-e>", "<C-\\><C-N>") --exit term mode

-- an auto terminal opener
vim.keymap.set("n", '<S-F3>', ':vs<Enter><C-w>l:term<Enter>i')
vim.keymap.set("n", '<S-F4>', ':MinimapToggle<Enter>')

-- vim.lsp.set_log_level("debug")

