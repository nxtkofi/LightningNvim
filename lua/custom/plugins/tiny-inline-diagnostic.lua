return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach", -- Or `VeryLazy`
	priority = 1000, -- needs to be loaded in first
	config = function()
		require("tiny-inline-diagnostic").setup({
			options = {
				multilines = true,
			},
		})
	end,
}
