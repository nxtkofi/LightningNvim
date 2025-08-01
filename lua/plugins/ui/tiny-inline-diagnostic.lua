return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 9000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "ghost",
			options = {
				multilines = true,
			},
		})
		vim.diagnostic.config({
			virtual_text = false,
		})
	end,
}
