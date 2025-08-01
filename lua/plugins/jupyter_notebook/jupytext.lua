return {
	lazy = false,
	"GCBallesteros/jupytext.nvim",
	config = function()
		require("jupytext").setup({
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		})
	end,
}
