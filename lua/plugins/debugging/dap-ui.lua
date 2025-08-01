-- lua/plugins/dap-ui.lua
return {
	"rcarriga/nvim-dap-ui",
	event = "VeryLazy", -- Można też rozważyć 'BufReadPre' lub 'BufNewFile' jeśli chcesz, by UI było gotowe od razu
	-- Zależności specyficzne dla UI lub integracji z DAP UI
	dependencies = {
		"mfussenegger/nvim-dap", -- Kluczowa zależność!
		"theHamsta/nvim-dap-virtual-text", -- Tekst inline
		"nvim-telescope/telescope-dap.nvim", -- Integracja z Telescope
	},
	opts = {
		-- Twoje opcje dla dap-ui (skopiowane z oryginalnej konfiguracji)
		controls = {
			element = "repl",
			enabled = true, -- Zmieniono na true, aby kontrolki były widoczne (jeśli chcesz)
			icons = {
				disconnect = "",
				pause = "",
				play = "",
				run_last = "",
				step_back = "",
				step_into = "",
				step_out = "",
				step_over = "",
				terminate = "",
			},
		},
		element_mappings = {},
		expand_lines = true,
		floating = {
			border = "single",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		force_buffers = true,
		icons = {
			collapsed = "",
			current_frame = "",
			expanded = "",
		},
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.50 },
					{ id = "stacks", size = 0.30 },
					{ id = "watches", size = 0.10 },
					{ id = "breakpoints", size = 0.10 },
				},
				size = 40,
				position = "left",
			},
			{
				elements = { -- Poprawiono formatowanie
					{ id = "repl", size = 0.5 },
					{ id = "console", size = 0.5 },
				},
				size = 10,
				position = "bottom",
			},
		},
		mappings = {
			edit = "e",
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			repl = "r",
			toggle = "t",
		},
		render = {
			indent = 1,
			max_value_lines = 100,
		},
	},
	config = function(_, opts)
		local dap = require("dap")
		local dapui = require("dapui")

		-- 1. Skonfiguruj dapui z przekazanymi opcjami (opts)
		dapui.setup(opts)

		-- 2. Skonfiguruj listenery DAP do kontrolowania UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			-- Zostawiono zakomentowane zgodnie z Twoim kodem
			-- dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			-- Zostawiono zakomentowane zgodnie z Twoim kodem
			-- dapui.close()
		end

		-- 3. Skonfiguruj nvim-dap-virtual-text (jeśli nie ma osobnej konfiguracji)
		local dap_virtual_text_present, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
		if dap_virtual_text_present then
			dap_virtual_text.setup({
				-- Domyślne opcje, dostosuj wg potrzeb
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				clear_on_continue = false, -- Ustaw na true, jeśli chcesz czyścić tekst po kontynuacji
				--- Virt text settings
				virt_text_pos = "eol", -- Position of virtual text
				all_frames = false, -- Show virtual text for all stack frames
				virt_lines = false, -- Show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- Virtual text is printed below normal text this many columns wide
			})
		else
			vim.notify("nvim-dap-virtual-text not found. Skipping setup.", vim.log.levels.WARN)
		end

		-- 4. Skonfiguruj telescope-dap (jeśli nie ma osobnej konfiguracji)
		local telescope_present, telescope = pcall(require, "telescope")
		if telescope_present then
			-- Można załadować rozszerzenie tutaj lub w konfiguracji telescope
			pcall(telescope.load_extension, "dap")
		-- Można dodać mapowania dla telescope-dap tutaj
		-- np. vim.keymap.set('n', '<leader>db', require('telescope').extensions.dap.breakpoints, { desc = 'DAP Breakpoints' })
		else
			vim.notify("Telescope not found. Skipping telescope-dap setup.", vim.log.levels.WARN)
		end

		print("nvim-dap-ui configured.") -- Komunikat kontrolny
	end,
}
