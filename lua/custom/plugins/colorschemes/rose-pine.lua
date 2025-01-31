return {
	"rose-pine/neovim",
	priority = 1000,
	name = "rose-pine",
	cond = vim.g.setup.colorscheme == "rose-pine",
	config = function()
		require("rose-pine").setup({
			styles = {
				bold = true,
				italic = true,
				transparency = vim.g.transparent_enabled,
			},
		})
		vim.cmd.colorscheme("rose-pine")
	end,
}
