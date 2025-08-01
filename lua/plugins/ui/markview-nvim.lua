return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	priority = 49, -- 49 because treesitter is 50. issue: https://github.com/OXY2DEV/markview.nvim/issues/365 --
	ft = { "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
	opts = {
		filetypes = {
			"markdown",
			"norg",
			"rmd",
			"org",
			"vimwiki",
			"Avante",
		},
	},
	config = function()
		local presets_checkboxes = require("markview.presets").checkboxes
		local presets_headings = require("markview.presets").headings
		local presets_horizontal = require("markview.presets").horizontal_rules
		require("markview").setup({
			preview = {
				enable = true,
				modes = { "n", "i", "c" },
				hybrid_modes = { "n", "i", "c" },
				render_distance = { 200, 200 },
				debounce = 50,
			},
			markdown = {
				headings = presets_headings.glow, --other cool opts are  or presets.glow_center
				horizontal_rules = presets_horizontal.thick,
			},
			markdown_inline = {
				checkboxes = presets_checkboxes.nerd,
			},
			latex = {
				enable = true,
				inlines = { enable = true },
				commands = {
					["sin"] = {},
				},
			},
		})

		require("markview.extras.checkboxes").setup({
			---@type string
			default = "X",
			---@type
			---| "disable"
			---| "checkbox"
			---| "list_item"
			remove_style = "disable",
			---@type string[][]
			states = {
				{ " ", "/", "X" },
				{ "<", ">" },
				{ "?", "!", "*" },
				{ '"' },
				{ "l", "b", "i" },
				{ "S", "I" },
				{ "p", "c" },
				{ "f", "k", "w" },
				{ "u", "d" },
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
