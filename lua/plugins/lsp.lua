return {
    'neovim/nvim-lspconfig',
    dependencies = {
	{ 'williamboman/mason.nvim', config = true }, -- lsp package manager
	'williamboman/mason-lspconfig.nvim', -- lsp package manager
	"hrsh7th/nvim-cmp", -- auto completion
	{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} }, -- progress message
	'folke/neodev.nvim', -- plugin signature help
    },
}



