return {
	"rose-pine/neovim",
	priority = 1004,
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			styles = {
				bold = true,
				italic = true,
				transparency = vim.g.transparent_enabled,
			},
		})
		--[[ vim.cmd.colorscheme("rose-pine-moon") ]]
	end,
}
