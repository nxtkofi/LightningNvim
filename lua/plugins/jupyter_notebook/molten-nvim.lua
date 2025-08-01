-- Installation guide: https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md
-- You also need this: https://github.com/benlubas/molten-nvim/blob/main/docs/Virtual-Environments.md
return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
	},
}
