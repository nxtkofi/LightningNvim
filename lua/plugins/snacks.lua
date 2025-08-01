return {
	"folke/snacks.nvim",
	opts = {
		explorer = {},
		bigfile = {
			size = 1024 * 1024 * 1.5,
		},
		picker = {
			sources = {
				explorer = {
					layout = { layout = { position = "right" } },
					follow_file = true,
					hidden = true,
					jump = { close = false },
					supports_live = false,
					git_untracked = true,
				},
			},
		},
	},
}
