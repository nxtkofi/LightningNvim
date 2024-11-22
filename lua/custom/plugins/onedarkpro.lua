return {
	"olimorris/onedarkpro.nvim",
	config = function()
		require("onedarkpro").setup({
			options = {
				cursorline = true,
				terminal_colors = true,
				transparency = vim.g.transparent_enabled,
				theme = "onedark",
			},
		})
	end,
}
