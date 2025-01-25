return {
	"olimorris/onedarkpro.nvim",
	priority = 1008,
	config = function()
		require("onedarkpro").setup({
			filetypes = { markdown = false },
			render_markdown = false,
			highlights = {
				CurSearch = { fg = "#0a805c", bg = "#add1d7", style = "reverse" },
				--[[ MarkviewCheckboxUnchecked = { fg = "#0a805c" }, ]]
			},
			options = {
				cursorline = false,
				terminal_colors = true,
				transparency = true,
			},
		})
		-- Apply the colorscheme
		require("onedarkpro").load()

		-- Clear markdownH* highlight groups AFTER loading the colorscheme
		for i = 1, 6 do
			vim.cmd("highlight clear markdownH" .. i)
		end
	end,
}
