return {
	"catppuccin/nvim",
	priority = 1000,
	cond = vim.g.setup.colorscheme == "catppuccin",
	config = function()
		require("catppuccin").setup({
		transparent_background = vim.g.setup.transparency,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
