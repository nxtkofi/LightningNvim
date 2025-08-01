return {
	"bluz71/vim-nightfly-colors",
	cond = vim.g.setup.colorscheme == "nightfly",
	name = "nightfly",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.nightflyTransparent = vim.g.setup.transparency
		vim.cmd.colorscheme("nightfly")
	end,
}
