-- NOTE: Download lua-language-server from Your package manager e.g `yay -S lua-language-server`
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	telemetry = { enabled = false },
	formatters = {
		ignoreComments = false,
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			signatureHelp = { enabled = true },
			completion = {
				callSnippet = "Replace",
			},
			workspace = {
				-- Nie każ serwerowi ładować ogromnej liczby plików przy starcie
				maxPreload = 2000,
				preloadFileSize = 1000,
				-- WAŻNE: Lista katalogów do ignorowania. Dostosuj ją do swoich potrzeb.
				ignoreDir = {
					".git",
					"node_modules",
					"__pycache__",
					".cache",
					".local",
					".config",
					"Downloads",
					"Pictures",
					"Documents",
					"Videos",
					"apps",
					"games",
				},
				-- To rozwiązuje problem nr 1: nierozpoznawanie 'vim'
				-- Informuje serwer o bibliotekach środowiska Neovim
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			-- To również pomaga w problemie nr 1
			diagnostics = {
				-- Daj serwerowi znać, że 'vim' jest predefiniowaną zmienną globalną
				globals = { "vim" },
			},
			-- Poprawia wydajność, wyłączając diagnostykę dla plików, których nie otworzyłeś
			diagnosticsOnOpen = true,
			diagnosticsOnSave = true,
			-- Wyłącz diagnostykę dla całego workspace, używaj tylko dla otwartych plików
			workspaceDiagnostics = false,
		},
	},
}
