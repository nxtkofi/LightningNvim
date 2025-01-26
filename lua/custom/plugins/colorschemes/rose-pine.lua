return {
	"rose-pine/neovim",
	priority = 1004,
	name = "rose-pine",
	config = function()
		local setup = require("setup")
		if setup.colorscheme == "rose-pine" then
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = true,
					transparency = vim.g.transparent_enabled,
				},
			})
			vim.cmd.colorscheme("rose-pine-moon")
		end
	end,
}
