return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	cond = vim.g.setup.colorscheme == "kanagawa",
	config = function()
		require("kanagawa").setup({
			transparent = vim.g.transparent_enabled,
			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
					TelescopeSelection = { fg = "#d27e99", bg = "#334155" },
					WinSeparator = { fg = "#7D7D7D" },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa")
		local function changeVisual()
			if vim.o.background == "dark" and vim.g.colors_name == "kanagawa" then
				vim.api.nvim_set_hl(0, "Visual", { bg = "#334155" })
				vim.api.nvim_set_hl(0, "@tag.tsx", { fg = "#fcb8d5" })
			end
		end
		changeVisual()
	end,
}
