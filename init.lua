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

    --{ 'folke/which-key.nvim',  opts = {} }, -- show keybinds

    'Bekaboo/deadcolumn.nvim', -- 80 textline limit

    'simrat39/symbols-outline.nvim', -- symbols outline

    { 'nvim-tree/nvim-tree.lua', 'nvim-tree/nvim-web-devicons' }, -- file tree

    -- indent tracker
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

    require 'plugins.lsp', -- call lsp setup
    require 'plugins.autocomplete', -- call autocompletion
    require 'plugins.telescope', -- fuzy finder
    require 'plugins.treesitter', -- tree sitter for highlighting
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


pcall(require('telescope').load_extension, 'fzf')

vim.cmd('source ~/.config/nvim/lua/configure/goyo.vim')
require 'configure.telescope'
require 'configure.treesitter'
require 'configure.lsp'
require 'configure.autocomplete'
require 'configure.trees'
require 'configure.indent'

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


-- vim.lsp.set_log_level("debug")
