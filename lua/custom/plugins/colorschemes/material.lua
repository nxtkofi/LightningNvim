return {
	"marko-cerovac/material.nvim",
	priority = 1000,
	cond = vim.g.setup.colorscheme == "material",
	config = function()
		require("material").setup({})
		vim.cmd.colorscheme("material")
	end,
}
