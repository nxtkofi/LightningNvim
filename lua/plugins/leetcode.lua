return {
	"kawre/leetcode.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		---@type string
		arg = "leetcode.nvim",
		---@type lc.lang
		lang = "typescript",
		---@type lc.storage
		storage = {
			home = vim.fn.stdpath("data") .. "/leetcode",
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		},
		---@type lc.picker
		picker = { provider = "telescope" },
	},
}
