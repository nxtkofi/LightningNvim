return {
	cond = vim.g.setup.colorscheme == "cyberdream",
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			-- Set light or dark variant
			variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
			transparent = vim.g.setup.transparency,
		})
		vim.cmd.colorscheme("cyberdream")
	end,
}
