local function find_assets_dir(max_depth)
	local current_path = vim.fn.expand("%:p:h")
	local visited_paths = {}

	local function search_up_and_down(path, depth)
		if depth > max_depth or visited_paths[path] then
			return nil
		end
		visited_paths[path] = true

		-- Sprawdź, czy w bieżącym katalogu istnieje folder `assets`
		if vim.fn.isdirectory(path .. "/assets") == 1 then
			return path .. "/assets"
		end

		-- Rekurencyjne przeszukiwanie: w górę
		local parent = vim.fn.fnamemodify(path, ":h")
		if parent ~= path then
			local found_up = search_up_and_down(parent, depth + 1)
			if found_up then
				return found_up
			end
		end

		-- Rekurencyjne przeszukiwanie: w dół
		local children = vim.fn.glob(path .. "/*", 1, 1)
		for _, child in ipairs(children) do
			if vim.fn.isdirectory(child) == 1 then
				local found_down = search_up_and_down(child, depth + 1)
				if found_down then
					return found_down
				end
			end
		end

		return nil
	end

	return search_up_and_down(current_path, 0)
end

local function sanitize_filename(filename)
	-- Zamień spacje na "-"
	return filename:gsub("%s", "-")
end

return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		default = {
			use_absolute_path = false, ---@type boolean

			-- make dir_path relative to current file rather than the cwd
			-- To see your current working directory run `:pwd`
			-- So if this is set to false, the image will be created in that cwd
			-- In my case, I want images to be where the file is, so I set it to true
			relative_to_current_file = false, ---@type boolean
			dir_path = function()
				local assets_dir = find_assets_dir(3) -- Maksymalna głębokość 3
				if assets_dir then
					local sanitized_name = sanitize_filename(vim.fn.expand("%:t:r"))
					return assets_dir .. "/" .. sanitized_name .. "-img"
				else
					error("No 'assets' directory found within 3 levels.")
				end
			end,
			prompt_for_file_name = false, ---@type boolean
			file_name = "%Y-%m-%d-at-%H-%M-%S", ---@type string
			-- -- Set the extension that the image file will have
			-- -- I'm also specifying the image options with the `process_cmd`
			-- -- Notice that I HAVE to convert the images to the desired format
			-- -- If you don't specify the output format, you won't see the size decrease

			extension = "avif", ---@type string
			process_cmd = "convert - -quality 75 avif:-", ---@type string

			-- -- Here are other conversion options to play around
			-- -- Notice that with this other option you resize all the images
			-- process_cmd = "convert - -quality 75 -resize 50% png:-", ---@type string
			-- extension = "webp", ---@type string
			-- process_cmd = "convert - -quality 75 webp:-", ---@type string

			-- extension = "png", ---@type string
			-- process_cmd = "convert - -quality 75 png:-", ---@type string

			--extension = "jpg", ---@type string
			--process_cmd = "convert - -quality 75 jpg:-", ---@type string

			-- -- Other parameters I found in stackoverflow
			-- -- https://stackoverflow.com/a/27269260
			-- --
			-- -- -depth value
			-- -- Color depth is the number of bits per channel for each pixel. For
			-- -- example, for a depth of 16 using RGB, each channel of Red, Green, and
			-- -- Blue can range from 0 to 2^16-1 (65535). Use this option to specify
			-- -- the depth of raw images formats whose depth is unknown such as GRAY,
			-- -- RGB, or CMYK, or to change the depth of any image after it has been read.
			-- --
			-- -- compression-filter (filter-type)
			-- -- compression level, which is 0 (worst but fastest compression) to 9 (best but slowest)
			-- process_cmd = "convert - -depth 24 -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 png:-",
			--
			-- -- These are for jpegs
			-- process_cmd = "convert - -sampling-factor 4:2:0 -strip -interlace JPEG -colorspace RGB -quality 75 jpg:-",
			-- process_cmd = "convert - -strip -interlace Plane -gaussian-blur 0.05 -quality 75 jpg:-",
			--
		},

		-- filetype specific options
		filetypes = {
			markdown = {
				-- encode spaces and special characters in file path
				url_encode_path = true, ---@type boolean

				-- -- The template is what specifies how the alternative text and path
				-- -- of the image will appear in your file
				--
				-- -- $CURSOR will paste the image and place your cursor in that part so
				-- -- you can type the "alternative text", keep in mind that this will
				-- -- not affect the name that the image physically has
				template = "![$CURSOR]($FILE_PATH)", ---@type string
				--
				-- -- This will just statically type "Image" in the alternative text
				-- template = "![Image]($FILE_PATH)", ---@type string
				--
				-- -- This will dynamically configure the alternative text to show the
				-- -- same that you configured as the "file_name" above
				--template = "![$FILE_NAME]($FILE_PATH)", ---@type string
			},
		},
	},
	keys = {
		-- suggested keymap
		{ "<leader>v", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
	},
}
