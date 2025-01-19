return {
	"tadaa/vimade",
	opts = {
		recipe = { "default", { animate = true } },
		fadelevel = 0.65,
		tint = {
			fg = { rgb = { 120, 120, 120 }, intensity = 1 }, -- all text will be gray
		},
		blocklist = {
			default = {
				highlights = {
					-- Prevent ActiveTabs from highlighting.
					"TabLineSel",
					-- Exact highlight names are supported:
					"WinSeparator",
					-- Lua patterns are supported, just put the text between / symbols:
					"/^SignColumn.*/",
					"/^StatusLine.*/",
					"LuaLine",
					"/^LuaLine.*/",
				},
				buf_opts = { buftype = { "prompt" } },
				-- buf_name = {'name1','name2', name3'},
				-- buf_vars = { variable = {'match1', 'match2'} },
				-- win_opts = { option = {'match1', 'match2' } },
				-- win_vars = { variable = {'match1', 'match2'} },
				-- win_type = {'name1','name2', name3'},
				-- win_config = { variable = {'match1', 'match2'} },
			},
		},
	},
}
