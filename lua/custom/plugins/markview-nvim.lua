return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	-- ft = "markdown" -- If you decide to lazy-load anyway
	config = function()
		local presets_checkboxes = require("markview.presets").checkboxes
		local presets_headings = require("markview.presets").headings
		local presets_horizontal = require("markview.presets").horizontal_rules
		require("markview").setup({
			checkboxes = presets_checkboxes.nerd,
			headings = presets_headings.simple, --other cool opts are presets.arrowed or presets.glow_center
			horizontal_rules = presets_horizontal.double,
			modes = { "n" },
			hybrid_modes = { "n" },
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
