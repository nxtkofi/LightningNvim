return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local obsidian_alpha_integration = require("utils.obsidian_alpha_integration")
		_Gopts = {
			position = "center",
			hl = "Type",
			wrap = "overflow",
		}

		local function get_all_files_in_dir(dir)
			local files = {}
			local scan = vim.fn.globpath(dir, "**/*.lua", true, true)
			for _, file in ipairs(scan) do
				table.insert(files, file)
			end
			return files
		end

		local function load_random_header()
			math.randomseed(os.time())
			local header_folder = vim.fn.stdpath("config") .. "/lua/alpha_images/"
			local files = get_all_files_in_dir(header_folder)

			if #files == 0 then
				return nil
			end

			local random_file = files[math.random(#files)]
			local relative_path = random_file:sub(#header_folder + 1)
			local module_name = "alpha_images." .. relative_path:gsub("/", "."):gsub("\\", "."):gsub("%.lua$", "")

			package.loaded[module_name] = nil

			local ok, module = pcall(require, module_name)
			if ok and module.header then
				return module.header
			else
				return nil
			end
		end

		local function change_header()
			local new_header = load_random_header()
			if new_header then
				dashboard.config.layout[2] = new_header
				vim.cmd("AlphaRedraw")
			else
				print("No images inside header_img folder.")
			end
		end

		local header = load_random_header()
		if header then
			dashboard.config.layout[2] = header
		else
			print("No images inside header_img folder.")
		end

		dashboard.section.tasks = {
			type = "text",
			val = obsidian_alpha_integration.get_today_tasks(),
			opts = {
				position = "center",
				hl = "Comment",
				width = 50,
			},
		}

		dashboard.section.buttons.val = {
			dashboard.button("<C-d>", "📝 Open daily-notes", ":Obsidian today<CR>"),
			dashboard.button(
				"<C-r>",
				"❓ Open random note",
				":lua require('utils.obsidian_alpha_integration').open_random_note()<CR>"
			),
			dashboard.button("<C-t>", "✅ Toggle tasks", function()
				obsidian_alpha_integration.show_interactive_tasks()
			end),
			dashboard.button("w", "🖌️ Change header image", function()
				change_header()
			end),
			dashboard.button("c", "🛠️ Settings", ":e $HOME/.config/nvim/init.lua<CR>"),
			dashboard.button("r", "⌛ Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("t", "🖮  Practice typing with Typr ", ":Typr<CR>"),
			dashboard.button("u", "🔌 Update plugins", "<cmd>Lazy update<CR>"),
		}

		dashboard.config.layout = {
			{ type = "padding", val = 3 },
			header,
			{ type = "padding", val = 2 },
			{
				type = "group",
				val = {
					{
						type = "group",
						val = {
							{
								type = "text",
								val = "📅 Tasks for today",
								opts = { hl = "Keyword", position = "center" },
							},
							dashboard.section.tasks,
						},
						opts = { spacing = 1 },
					},
					{
						type = "group",
						val = dashboard.section.buttons.val,
						opts = { spacing = 1 },
					},
				},
				opts = {
					layout = "horizontal",
				},
			},
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimStarted",
			desc = "Add Alpha dashboard footer",
			once = true,
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
				dashboard.section.footer.val =
					{ " ", " ", " ", " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms " }
				dashboard.section.header.opts.hl = "DashboardFooter"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)
	end,
}
