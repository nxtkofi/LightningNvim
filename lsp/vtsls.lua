---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
-- NOTE: Download vtsls from Your package manager e.g `yay -S vtsls`
return {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "javascript", "vue", "typescript", "typescriptreact" },
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/usr/bin/vue-language-server",
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
	on_attach = function(client, bufnr)
		if vim.bo[bufnr].filetype == "vue" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
}
