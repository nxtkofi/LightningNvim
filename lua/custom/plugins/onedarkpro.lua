return {
	"olimorris/onedarkpro.nvim",
	priority = 1001,
	config = function()
		require("onedarkpro").setup({
			highlights = {
				CurSearch = { fg = "#0a805c", bg = "#add1d7", style = "reverse" },
			},
			options = {
				highlight_inactive_windows = true,
				window_unfocused_color = true,
				cursorline = false,
				terminal_colors = true,
				transparency = true,
				theme = "onedark",
			},
		})
	end,
}
