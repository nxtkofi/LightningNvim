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
			local module_name = "custom.plugins.header_img." .. random_file:match("([^/]+)%.lua$")
			return require(module_name).header
		end

		local function change_header()
			local new_header = load_random_header()
			if new_header then
				dashboard.config.layout[2] = new_header
				vim.cmd("AlphaRedraw") -- Przeładuj dashboard
			else
				print("Brak plików nagłówków w folderze header_img.")
			end
		end

		-- Inicjalne załadowanie nagłówka
		local header = load_random_header()
		if header then
			dashboard.config.layout[2] = header
		else
			print("Brak plików nagłówków w folderze header_img.")
		end

		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button(
				"f",
				"  Find file",
				":cd $HOME | silent Telescope find_files hidden=true no_ignore=true <CR>"
			),
			dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy update<CR>"),
			dashboard.button("c", "  Settings", ":e $HOME/.config/nvim/init.lua<CR>"),
			dashboard.button("p", "  Projects", ":e $HOME/Dev/Projects <CR>"),
			dashboard.button("d", "󱗼  Dotfiles", ":e $HOME/dotfiles <CR>"),
			dashboard.button("w", "  Change header image", function()
				change_header()
			end),
			dashboard.button("q", "󰿅  Quit", "<cmd>qa<CR>"),
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
