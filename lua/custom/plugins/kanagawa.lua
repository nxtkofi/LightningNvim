return {
	priority = 1000,
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			transparent = vim.g.transparent_enabled,
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
