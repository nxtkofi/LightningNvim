return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				vim.lsp.buf.code_action({
					apply = true,
					context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
				})
				vim.lsp.buf.code_action({
					apply = true,
					context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
				})
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer and add missing imports",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 2500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			tex = { "latexindent" },
		},
		formatters = {
			latexindent = {
				prepend_args = { "-c=.indent" },
			},
		},
	},
}
