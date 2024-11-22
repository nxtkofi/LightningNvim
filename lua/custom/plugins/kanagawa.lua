return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			transparent = vim.g.transparent_enabled,
		})

		vim.cmd.colorscheme("kanagawa")
	end,
}
