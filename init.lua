vim.g.setup = require("setup")
require("core.options")
require("core.lazy")
require("core.autocmds")
require("core.keymaps")

vim.lsp.enable({
	"luals",
	"ltex",
	"vtsls",
	"vue_ls",
	"omnisharp",
	"tailwindcss",
})
