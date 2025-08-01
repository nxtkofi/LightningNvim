local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ import = "plugins" },
	{ import = "plugins.debugging" },
	{ import = "plugins.jupyter_notebook" },
	{ import = "colorschemes" },
	{ import = "plugins.ui" },
	{ import = "plugins.ai" },
	{ import = "plugins.git" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
	change_detection = {
		notify = false,
	},
})
