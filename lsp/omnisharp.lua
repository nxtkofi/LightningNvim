-- yay -S mono-msbuild
-- Download OmniSharp from their official github, unpack it and place it in Your PATH
local util = require("lspconfig.util")

return {
	cmd = {
		vim.fn.executable("OmniSharp") == 1 and "OmniSharp" or "omnisharp",
		"-z", -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
		"--hostPID",
		tostring(vim.fn.getpid()),
		"DotNet:enablePackageRestore=false",
		"--encoding",
		"utf-8",
		"--languageserver",
	},
	filetypes = { "cs", "vb" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(
			util.root_pattern("*.sln")(fname)
				or util.root_pattern("*.csproj")(fname)
				or util.root_pattern("omnisharp.json")(fname)
				or util.root_pattern("function.json")(fname)
		)
	end,
	init_options = {},
	capabilities = {
		workspace = {
			workspaceFolders = false, -- https://github.com/OmniSharp/omnisharp-roslyn/issues/909
		},
	},
	settings = {
		FormattingOptions = {
			-- Enables support for reading code style, naming convention and analyzer
			-- settings from .editorconfig.
			EnableEditorConfigSupport = true,
			-- Specifies whether 'using' directives should be grouped and sorted during
			-- document formatting.
			OrganizeImports = true,
		},
		MsBuild = {
			-- If true, MSBuild project system will only load projects for files that
			-- were opened in the editor. This setting is useful for big C# codebases
			-- and allows for faster initialization of code navigation features only
			-- for projects that are relevant to code that is being edited. With this
			-- setting enabled OmniSharp may load fewer projects and may thus display
			-- incomplete reference lists for symbols.
			LoadProjectsOnDemand = nil,
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true,
			EnableImportCompletion = true,
			AnalyzeOpenDocumentsOnly = nil,
			EnableDecompilationSupport = nil,
		},
		RenameOptions = {
			RenameInComments = nil,
			RenameOverloads = nil,
			RenameInStrings = nil,
		},
		Sdk = {
			-- Specifies whether to include preview versions of the .NET SDK when
			-- determining which version to use for project loading.
			IncludePrereleases = true,
		},
	},
}
