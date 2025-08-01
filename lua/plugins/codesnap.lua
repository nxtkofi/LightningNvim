return {
	"mistricky/codesnap.nvim",
	build = "make",
	keys = {
		{ "<leader>cc", "<Esc><cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
		-- <Esc> Included as it is a workaround to overcome this bug:https://github.com/mistricky/codesnap.nvim/issues/103
	},

	config = function()
		require("codesnap").setup({
			watermark = "",
			bg_x_padding = 60,
			bg_y_padding = 60,
			bg_padding = nil,
			watermark_font_family = "FiraCode Nerd Font Propo",
			has_breadcrumbs = true,
			bg_theme = "sea",
		})
	end,
}
