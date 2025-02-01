return {
	"folke/snacks.nvim",
	opts = {
		explorer = {},
		picker = {
			sources = {
				explorer = {
					layout = { layout = { position = "right" } },
					follow_file = false,
					jump = { close = false },
					supports_live = false,
				},
			},
		},
	},
}
