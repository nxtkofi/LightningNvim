return {
	"3rd/time-tracker.nvim",
	dependencies = {
		"3rd/sqlite.nvim",
	},
	event = "VeryLazy",
	opts = {
		data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
	},
	config = function()
		require("time-tracker").setup({
			data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
			tracking_events = { "BufEnter", "BufWinEnter", "CursorMoved", "CursorMovedI", "WinScrolled" },
			tracking_timeout_seconds = 5 * 60, -- 5 minutes
		})
	end,
}
