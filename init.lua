
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
})


require("autoclose").setup({
  keys = {
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

--vim.cmd('source ~/.config/nvim/lua/custom/plugins/goyo.vim')

-- =========================== OPTIONS =====================
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
