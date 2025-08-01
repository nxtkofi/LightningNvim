return {
	"azorng/goose.nvim",
	config = function()
		require("goose").setup({})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
