return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1002, -- needs to be loaded in first
	config = function()
		require("tiny-inline-diagnostic").setup({
			options = {
				multilines = true
			}
		})
	end,
}
