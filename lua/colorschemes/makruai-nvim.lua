return {
	"Skardyy/makurai-nvim",
	cond = vim.g.setup.colorscheme == "makurai",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("makurai")
	end,
}
