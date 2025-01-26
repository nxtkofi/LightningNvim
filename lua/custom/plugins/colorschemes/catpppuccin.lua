return {
	"catppuccin/nvim",
	priority = 1009,
	config = function()
		local setup = require("setup")
		if setup.colorscheme == "catppuccin" then
			require("catppuccin").setup({
				transparent_background = vim.g.transparent_enabled,
			})
			vim.cmd.colorscheme("catppuccin")
		end
	end,
}
