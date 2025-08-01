return {
	"3rd/image.nvim",
	config = function()
		require("image").setup({
			backend = "kitty",
			kitty_method = "normal",
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					-- Set this to false if you don't want to render images coming from
					-- a URL
					download_remote_images = true,
					only_render_image_at_cursor = true,
					filetypes = { "markdown", "vimwiki" },
				},
				neorg = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "norg" },
				},
				html = {
					enabled = true,
				},
				css = {
					enabled = true,
				},
			},
			max_width = 100,
			max_height = 28,
			max_width_window_percentage = math.huge,
			max_height_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

			editor_only_render_when_focused = true,

			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
		})
	end,
}
