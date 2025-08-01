-- lua/plugins/dap.lua
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		{
			"microsoft/vscode-js-debug",
			version = "1.x",
			build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
		},

		"mxsdev/nvim-dap-vscode-js",
	},

	config = function()
		local dap = require("dap")
		local js_debug_path = vim.fn.stdpath("data")
			.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
		local node_path = vim.fn.exepath("node") -- używa node z PATH

		for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
			local pwaType = "pwa-" .. adapterType

			dap.adapters[pwaType] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = node_path,
					args = { js_debug_path, "${port}" },
				},
			}

			dap.adapters[adapterType] = function(cb, config)
				local nativeAdapter = dap.adapters[pwaType]

				config.type = pwaType

				if type(nativeAdapter) == "function" then
					nativeAdapter(cb, config)
				else
					cb(nativeAdapter)
				end
			end
		end

		local enter_launch_url = function()
			local co = coroutine.running()
			return coroutine.create(function()
				vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
					if url and url ~= "" then
						coroutine.resume(co, url)
					end
				end)
			end)
		end

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug TS file via ts-node",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeArgs = { "-r", "ts-node/register" },
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process using Node.js (nvim-dap)",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file using ts-node/register (nvim-dap)",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeArgs = { "-r", "ts-node/register" },
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome (nvim-dap)",
					url = enter_launch_url,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
				},
				{
					type = "pwa-msedge",
					request = "launch",
					name = "Launch Edge (nvim-dap)",
					url = enter_launch_url,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
				},
			}
		end

		dap.configurations.java = {
			{
				name = "Debug Launch (2GB)",
				type = "java",
				request = "launch",
				vmArgs = "-Xmx2g",
			},
			{
				name = "Debug Attach (8000)",
				type = "java",
				request = "attach",
				hostName = "127.0.0.1",
				port = 8000,
			},
			{
				name = "Debug Attach (5005)",
				type = "java",
				request = "attach",
				hostName = "127.0.0.1",
				port = 5005,
			},
			{
				name = "My Custom Java Run Configuration",
				type = "java",
				request = "launch",
				mainClass = "replace.with.your.fully.qualified.MainClass",
				vmArgs = "-Xmx2g",
			},
		}
		print("nvim-dap core configured.")
	end,
}
