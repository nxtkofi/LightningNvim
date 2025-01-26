return {
	"marko-cerovac/material.nvim",
	config = function()
		local setup = require("setup")
		if setup.colorscheme == "material" then
			require("material").setup({})
			vim.cmd.colorscheme("material")
		end
	end,
}
