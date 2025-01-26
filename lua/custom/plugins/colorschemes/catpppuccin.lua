return {
	"catppuccin/nvim",
	--[[ priority = 1009, ]]
	config = function()
		require("catppuccin").setup({
			transparent_background = vim.g.transparent_enabled,
		})
		--[[ vim.cmd.colorscheme("catppuccin") ]]
	end,
}
