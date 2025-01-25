return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		_Gopts = {
			position = "center",
			hl = "Type",
			wrap = "overflow",
		}

		local function load_random_header()
			math.randomseed(os.time())
			local header_folder = vim.fn.stdpath("config") .. "/lua/custom/plugins/header_img/"
			local files = vim.fn.globpath(header_folder, "*.lua", true, true)
			if #files == 0 then
				return nil
			end

			local random_file = files[math.random(#files)]
			local separator = package.config:sub(1, 1)
			local module_name = "custom.plugins.header_img." .. random_file:match("([^" .. separator .. "]+)%.lua$")

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
				vim.cmd("AlphaRedraw") -- Przeładuj dashboard
			else
				print("No images inside header_img folder.")
			end
		end

		-- Inicjalne załadowanie nagłówka
		local header = load_random_header()
		if header then
			dashboard.config.layout[2] = header
		else
			print("No images inside header_img folder.")
		end

		dashboard.section.buttons.val = {
			dashboard.button("<C-d>", "󱓧  Open daily-notes", ":ObsidianToday<CR>"),
			dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
			dashboard.button("c", "  Settings", ":e $HOME/.config/nvim/init.lua<CR>"),
			dashboard.button("w", "  Change header image", function()
				change_header()
			end),
			dashboard.button("t", "🖮  Practice typing with Typr ", ":Typr<CR>"),
		}

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
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
