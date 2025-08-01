return {
	"cljoly/telescope-repo.nvim",
	requires = "nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").load_extension("repo")
	end,
}
