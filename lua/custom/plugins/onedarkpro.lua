return {
	"olimorris/onedarkpro.nvim",
	priority = 1001,
	config = function()
		require("onedarkpro").setup({
			highlights = {
				CurSearch = { fg = "#0a805c", bg = "#add1d7", style = "reverse" },
			},
			options = {
				cursorline = false,
				terminal_colors = true,
				transparency = true,
				theme = "onedark",
			},
		})
		vim.cmd.colorscheme("onedark_vivid")
	end,
}
