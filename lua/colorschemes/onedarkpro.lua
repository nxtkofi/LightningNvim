return {
	"olimorris/onedarkpro.nvim",
	priority = 1000,
	cond = vim.g.setup.colorscheme == "onedarkpro",
	config = function()
		require("onedarkpro").setup({
			filetypes = { markdown = false },
			render_markdown = false,
			highlights = {
				CurSearch = { fg = "#0a805c", bg = "#add1d7", style = "reverse" },
			},
			options = {
				cursorline = false,
				terminal_colors = true,
				transparency = vim.g.setup.transparency,
			},
		})
		vim.cmd.colorscheme("onedark")
		for i = 1, 6 do
			vim.cmd("highlight clear markdownH" .. i)
		end
	end,
}
