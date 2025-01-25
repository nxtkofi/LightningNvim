return {
	"olimorris/onedarkpro.nvim",
	priority = 1008,
	config = function()
		local setup = require("setup")
		if setup.colorscheme == "onedark" then
			require("onedarkpro").setup({
				filetypes = { markdown = false },
				render_markdown = false,
				highlights = {
					CurSearch = { fg = "#0a805c", bg = "#add1d7", style = "reverse" },
				},
				options = {
					cursorline = false,
					terminal_colors = true,
					transparency = true,
				},
			})
			vim.cmd.colorscheme("onedark_vivid")
			for i = 1, 6 do
				vim.cmd("highlight clear markdownH" .. i)
			end
		end
	end,
}
