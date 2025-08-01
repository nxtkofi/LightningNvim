return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			theme = "auto",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
			lualine_z = {
				{
					function()
						return " " .. os.date("%R")
					end,
					separator = { left = "", right = "" },
					left_padding = 2,
				},
			},
		},
	},
}
