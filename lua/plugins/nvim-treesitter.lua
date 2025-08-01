return {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	depenencies = {
		"OXY2DEV/markview.nvim",
	},
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
		},
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true, disable = { "ruby" } },
	},
}
