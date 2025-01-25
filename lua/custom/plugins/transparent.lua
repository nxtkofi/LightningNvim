return {
	"xiyaowong/transparent.nvim",
	priority = 1099,
	config = function()
		require("transparent").setup({
			groups = { -- Grupy, które będą miały przezroczyste tło
				"CursorLine",
				"NonText",
				"Operator",
				"Structure",
				"SignColumn",
				"LineNr",
				"WinSeparator",
				"CursorLineNr",
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
			},
			extra_groups = {
				"NeoTreeNormal",
				"NeoTreeNormalNC",
				"NeoTreeCursorLine",
				"GitSignsText",
				"GitSignsAdd",
				"GitSignsAdded",
				"GitSignsChange",
				"GitSignsChanged",
				"GitSignsDelete",
				"GitSignsDeleted",
				"GitSignsUpdate",
				"GitSignsUpdated",
				"GitSignsTopdelete",
				"GitSignsTopdeleteNr",
				"GitSignsUntracked",
				"GitSignsUntrackedNr",
				"DiagnosticSignError",
				"DiagnosticSignWarn",
				"DiagnosticSignInfo",
				"DiagnosticSignHint",
			}, -- Możesz tu dodać dodatkowe grupy, jeśli potrzebujesz
			exclude_groups = { -- Grupy, które pozostaną nieprzezroczyste
				"TinyInlineDiagnosticVirtualTextError",
				"TinyInlineDiagnosticVirtualTextWarn",
				"TinyInlineDiagnosticVirtualTextInfo",
				"TinyInlineDiagnosticVirtualTextHint",
				"TinyInlineDiagnosticVirtualTextArrow",
				"TinyInlineInvDiagnosticVirtualTextError",
				"TinyInlineInvDiagnosticVirtualTextWarn",
				"TinyInlineInvDiagnosticVirtualTextInfo",
				"TinyInlineInvDiagnosticVirtualTextHint",
				"MsgArea",
				"WinBar",
				"WinBarNC",
				"EndOfBuffer",
				"Float",
				"NormalFloat", -- Okna pływające, np. pomoc syntaxu (Shift+K)
				"FloatBorder", -- Obramowanie dla okien pływających
				"Term", -- Wszystkie okna terminalowe
				"StatusLine",
				"StatusLineNC",
				"VertSplit",
				"Split",
				"Separator",
				"Horizontal",
			},
		})
	end,
}
