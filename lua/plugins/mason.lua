-- NOTE: This is only kept here due to easy formatters AND debuggers integration.
-- WARNING: DO NOT use Mason to install LSP servers! Use Your systems Package Manager instead
return {
	"williamboman/mason.nvim",
	opts = {},
	dependencies = {
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
}
