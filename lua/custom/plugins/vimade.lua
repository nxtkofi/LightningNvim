return {
	"tadaa/vimade",
	enabled = true,
	opts = {
		recipe = { "default", { animate = true } },
		fadelevel = 0.65,
		enabled = false,
		tint = {
			fg = { rgb = { 120, 120, 120 }, intensity = 1 }, -- all text will be gray
		},
		blocklist = {
			custom = {
				highlights = {
					"EndOfBuffer",
					--[[ "/^NeoTree.*/", ]]
					--"/^lualine.*/", -- Uncomment this if You want to make lualine transparent
					"/^.undotree.*/",
					"/^undotree_highlight.*/",
					"/^Undotree.*/",
					"/^Outline.*/",
				},
			},
		},
	},
}
