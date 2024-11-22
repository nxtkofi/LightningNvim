return {
	"olimorris/onedarkpro.nvim",
	--[[ priority = 1000, ]]
	config = function()
		require("onedarkpro").setup({
			options = {
				cursorline = true,
				terminal_colors = true,
				transparency = vim.g.transparent_enabled,
				theme = "onedark",
			},
		})
		--[[ vim.cmd.colorscheme("onedark") ]]
	end,
}
