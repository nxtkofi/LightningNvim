return {
	"nvzone/typr",
	cmd = { "Typr", "TyprStats" },
	dependencies = "nvzone/volt",
	opts = {
		on_attach = function(buf)
			vim.b[buf].minipairs_disable = true
		end,
		mappings = function(buf)
			local typr = require("typr")
			vim.keymap.set("n", "1", function()
				typr.linecount = 1
			end, { buffer = buf, desc = "Set linecount to 1" })
		end,
	},
}
