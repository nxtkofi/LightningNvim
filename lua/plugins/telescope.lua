local setup = require("setup")
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					n = {
						["<c-w>"] = require("telescope.actions").delete_buffer,
					},
				},
			},
			extensions = {
				file_browser = { hijack_netrw = true },
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				repo = {
					list = {
						search_dirs = setup.search_dirs,
						mappings = {
							i = {
								["<CR>"] = function(prompt_bufnr)
									actions.close(prompt_bufnr)
									--[[ -- Set current repository path as neo-tree path ]]
									--[[ vim.cmd("Neotree close") -- CLose neo-tree if it's opened ]]
									--[[ vim.cmd(string.format("Neotree filesystem left dir=%s", entry.value)) -- Użycie string.format do otwarcia Neo-tree ]]
									--[[ print("Opened Neo-tree in directory: " .. entry.value) ]]
								end,
							},
						},
					},
				},
			},
		})
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
