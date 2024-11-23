return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			start_in_insert = true,
			authochdir = true,
			direction = "horizontal",
			winblend = 0,
		})
	end,
}
